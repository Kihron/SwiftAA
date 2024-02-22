//
//  SwiftAAViewModel.swift
//  SwiftAA
//
//  Created by Kihron on 1/2/23.
//

import SwiftUI

class AppViewModel: ObservableObject {
    @ObservedObject var dataManager = DataManager.shared
    @ObservedObject private var progressManager = ProgressManager.shared
    @ObservedObject private var trackerManager = TrackerManager.shared
    
    private var lastWorking = ""
    private var activeWindows = [pid_t:String]()
    private var wasCleared: Bool = true
    private let fileManager = FileManager.default
    
    private let regex = try! NSRegularExpression(pattern: ",\\s*\"DataVersion\"\\s*:\\s*\\d*|\"DataVersion\"\\s*:\\s*\\d*\\s*,?")
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            withAnimation {
                self.refreshData()
            }
        }
    }
    
    private func refreshData() {
        let saves: String
        if trackerManager.trackingMode == .directory {
            saves = trackerManager.customSavesPath
        } else {
            if let dir = getSavesFromActiveInstance(), !dir.isEmpty {
                saves = dir
                if (saves != lastWorking) {
                    lastWorking = saves
                }
            } else {
                saves = lastWorking
                if (saves.isEmpty) {
                    progressManager.clearProgressState()
                    trackerManager.alert = .enterMinecraft
                    return
                }
            }
        }

        readAllFileData(saves: saves)
    }
    
    private func readAllFileData(saves: String) {
        if (fileManager.fileExists(atPath: saves)) {
            do {
                let worldPath = getWorldPath(fileManager: fileManager, saves: saves)
                
                if (!["advancements", "stats"].allSatisfy(try fileManager.contentsOfDirectory(atPath: worldPath).contains)) {
                    progressManager.clearProgressState()
                    trackerManager.alert = .none
                    return
                }
                
                if (try fileManager.contentsOfDirectory(atPath: "\(worldPath)/advancements").isEmpty || fileManager.contentsOfDirectory(atPath: "\(worldPath)/stats").isEmpty) {
                    progressManager.clearProgressState()
                    trackerManager.alert = .invalidDirectory
                    return
                }
                
                let fileName = try fileManager.contentsOfDirectory(atPath: "\(worldPath)/advancements")[0]
                let lastUpdate = try getModifiedTime("\(worldPath)/advancements/\(fileName)", fileManager: fileManager) ?? Date.now
                
                if (dataManager.lastModified != lastUpdate) {
                    dataManager.lastModified = lastUpdate
                    var advFileContents = try String(contentsOf: URL(fileURLWithPath: "\(worldPath)/advancements/\(fileName)"))
                    let advRange = NSRange(location: 0, length: advFileContents.count)
                    advFileContents = regex.stringByReplacingMatches(in: advFileContents, range: advRange, withTemplate: "")
                    
                    let advancements = try JSONDecoder().decode([String:JsonAdvancement].self, from: Data(advFileContents.utf8))
                    let statistics = try JSONDecoder().decode(JsonStats.self, from: Data(contentsOf: URL(fileURLWithPath: "\(worldPath)/stats/\(fileName)")))
                    
                    trackerManager.alert = .none
                    updatePlayerInfo(fileName: fileName)
                    progressManager.updateProgressState(advancements: advancements, statistics: statistics.stats)
                }
            } catch {
                print(error.localizedDescription)
            }
        } else {
            trackerManager.resetWorldPath()
            if (saves.isEmpty) {
                trackerManager.alert = .noWorlds
                return
            }
            trackerManager.alert = .directoryNotFound
        }
    }
    
    private func getWorldPath(fileManager: FileManager, saves: String) -> String {
        do {
            let savesDirectoryUpdated = try getModifiedTime(saves, fileManager: fileManager)
            var world: String
            
            let logFile = "\(saves)/../logs/latest.log"
            let logUpdated = try getModifiedTime(logFile, fileManager: fileManager)
            
            var isNewWorld = false
            if (trackerManager.lastLogUpdate != logUpdated) {
                trackerManager.lastLogUpdate = logUpdated
                
                if let line = readLastLine(ofFileAtPath: logFile), line.contains("Loaded") && line.contains("advancements") {
                    isNewWorld = true
                }
            }
            
            if trackerManager.lastDirectoryUpdate != savesDirectoryUpdated || isNewWorld {
                trackerManager.lastDirectoryUpdate = savesDirectoryUpdated
                isNewWorld = false
                let contents = try fileManager.contentsOfDirectory(atPath: saves).filter({ folder in
                    folder != ".DS_Store"
                })
                if (contents.isEmpty) {
                    progressManager.clearProgressState()
                    throw TrackerAlert.noWorlds
                }
                
                world = try contents.max { a, b in
                    let date1 = try getModifiedTime("\(saves)/\(a)", fileManager: fileManager)
                    let date2 = try getModifiedTime("\(saves)/\(b)", fileManager: fileManager)
                    return date1?.compare(date2!) == ComparisonResult.orderedAscending
                }!
                
                world = "\(saves)/\(world)"
                trackerManager.worldPath = world
                return world
            } else {
                return trackerManager.worldPath
            }
        } catch {
            print(error.localizedDescription)
            return trackerManager.worldPath
        }
    }
    
    private func updatePlayerInfo(fileName: String) {
        Task {
            let uuid = String(fileName.dropLast(5))
            await PlayerManager.shared.updatePlayer(uuid: uuid)
        }
    }
    
    private func getModifiedTime(_ filePath: String, fileManager: FileManager) throws -> Date? {
        try fileManager.attributesOfItem(atPath: filePath)[FileAttributeKey.modificationDate] as? Date
    }
    
    private func getSavesFromActiveInstance() -> String? {
        let workspace = NSWorkspace.shared
        let apps = workspace.runningApplications.filter{  $0.activationPolicy == .regular }
        if let currentApp = apps.first(where: {$0.isActive}) {
            let pid = currentApp.processIdentifier
            if let path = activeWindows[pid] {
                return path
            }
            
            if let arguments = Utilities.processArguments(pid: pid) {
//                if let version = arguments.firstIndex(of: "--version") {
//                    print(arguments[version + 1])
//                }
                
                if let gameDirIndex = arguments.firstIndex(of: "--gameDir") {
                    let path = "\(arguments[gameDirIndex + 1])/saves"
                    activeWindows[pid] = path
                    return path
                }
                if let nativesArg = arguments.first(where: {$0.starts(with: "-Djava.library.path=")}) {
                    let path = "\(nativesArg.dropFirst(20).dropLast("natives".count)).minecraft/saves"
                    activeWindows[pid] = path
                    return path
                }
                activeWindows[pid] = ""
            }
        }
        return nil
    }
    
    private func readLastLine(ofFileAtPath path: String) -> String? {
        guard let fileHandle = FileHandle(forReadingAtPath: path) else {
            return nil
        }
        
        var offset: UInt64 = 0
        let fileSize = fileHandle.seekToEndOfFile()
        
        if fileSize == 0 { return nil }
        
        var data = Data()
        
        repeat {
            offset += 1
            fileHandle.seek(toFileOffset: fileSize - offset)
            let byteData = fileHandle.readData(ofLength: 1)
            if byteData[0] == 10 && offset != 1 { // 10 is ASCII for '\n'
                break
            }
            data.insert(contentsOf: byteData, at: 0)
        } while offset < fileSize
        
        fileHandle.closeFile()
        
        return String(data: data, encoding: .utf8)
    }
}
