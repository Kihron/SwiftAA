//
//  SwiftAAViewModel.swift
//  SwiftAA
//
//  Created by Kihron on 1/2/23.
//

import SwiftUI

class AppViewModel: ObservableObject {
    @ObservedObject var dataManager = DataManager.shared
    @ObservedObject private var trackerManager = TrackerManager.shared
    
    @Published var advancementsUpdated: Bool = false
    
    private var lastWorking = ""
    private var activeWindows = [pid_t:String]()
    private var wasCleared: Bool = true
    
    private let regex = try! NSRegularExpression(pattern: ",\\s*\"DataVersion\"\\s*:\\s*\\d*|\"DataVersion\"\\s*:\\s*\\d*\\s*,?")
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            withAnimation {
                self.refreshData()
            }
        }
    }
    
    private func refreshData() {
        advancementsUpdated = false
        
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
                    updateAll()
                    trackerManager.alert = .enterMinecraft
                    return
                }
            }
        }
        
        trackerManager.alert = readAllFileData(saves: saves)
    }
    
    private func readAllFileData(saves: String) -> TrackerAlert? {
        let fileManager = FileManager.default
        if (fileManager.fileExists(atPath: saves)) {
            do {
                let world = getWorldPath(fileManager: fileManager, saves: saves)
                
                if (!["advancements", "stats"].allSatisfy(try fileManager.contentsOfDirectory(atPath: world).contains)) {
                    updateAll()
                    return .none
                }
                
                if (try fileManager.contentsOfDirectory(atPath: "\(world)/advancements").isEmpty || fileManager.contentsOfDirectory(atPath: "\(world)/stats").isEmpty) {
                    updateAll()
                    return TrackerAlert.invalidDirectory
                }
                
                let fileName = try fileManager.contentsOfDirectory(atPath: "\(world)/advancements")[0]
                let lastUpdate = try getModifiedTime("\(world)/advancements/\(fileName)", fileManager: fileManager) ?? Date.now
                
                if (dataManager.lastModified != lastUpdate) {
                    dataManager.lastModified = lastUpdate
                    var advFileContents = try String(contentsOf: URL(fileURLWithPath: "\(world)/advancements/\(fileName)"))
                    let advRange = NSRange(location: 0, length: advFileContents.count)
                    advFileContents = regex.stringByReplacingMatches(in: advFileContents, range: advRange, withTemplate: "")
                    
                    let advancements = try JSONDecoder().decode([String:JsonAdvancement].self, from: Data(advFileContents.utf8))
                    let statistics = try JSONDecoder().decode(JsonStats.self, from: Data(contentsOf: URL(fileURLWithPath: "\(world)/stats/\(fileName)")))
                    
                    updatePlayerInfo(fileName: fileName)
                    updateAll(advancements: advancements, statistics: statistics.stats)
                }
            } catch {
                print(error.localizedDescription)
            }
        } else {
            if (saves.isEmpty) {
                updateAll()
                return TrackerAlert.noWorlds
            }
            updateAll()
            return TrackerAlert.directoryNotFound
        }
        return .none
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
                    updateAll()
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
            
            if let arguments = dataManager.processArguments(pid: pid) {
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
    
    private func updateAll(advancements: [String:JsonAdvancement] = [:], statistics: [String:[String:Int]] = [:]) {
        if (advancements.count == 0) {
            if (wasCleared) {
                return
            }
            wasCleared = true
            dataManager.lastModified = Date.now
        } else {
            wasCleared = false
        }
        
        let flatMap = dataManager.map.values.flatMap({$0})
        flatMap.forEach { adv in
            adv.update(advancements: advancements, stats: statistics)
        }
        
        dataManager.stats.forEach { stat in
            stat.update(advancements: advancements, stats: statistics)
        }
        
        dataManager.uncounted.forEach { adv in
            adv.update(advancements: advancements, stats: statistics)
        }
        
        let timeStat = TrackerManager.shared.gameVersion == .v1_16 ? "minecraft:play_one_minute" : "minecraft:play_time"
        
        dataManager.statsData = statistics
        dataManager.playTime = statistics["minecraft:custom"]?[timeStat] ?? 0
        dataManager.allAdvancements = dataManager.map.values.flatMap({$0}).filter({$0.completed}).count >= dataManager.map.values.compactMap({$0.count}).reduce(0, +)
        
        advancementsUpdated = true
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
