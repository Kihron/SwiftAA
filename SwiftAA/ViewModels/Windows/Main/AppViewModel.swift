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
    @ObservedObject private var playerManager = PlayerManager.shared
    
    private var lastWorking = ""
    private var activeWindows = [pid_t:(String, Version?)]()
    private let fileManager = FileManager.default
    
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
            if let info = getInstanceInfo(), !info.0.isEmpty {
                saves = info.0
                
                if (saves != lastWorking) {
                    lastWorking = saves
                }
                
                if let version = info.1, trackerManager.automaticVersionDetection {
                    if trackerManager.updateGameVersion(version: version) {
                        return
                    }
                }
            } else {
                saves = lastWorking
                if saves.isEmpty {
                    if trackerManager.updateErrorAlert(alert: .enterMinecraft) {
                        progressManager.clearProgressState()
                    }
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
                    if trackerManager.updateErrorAlert(alert: .noFiles) {
                        progressManager.clearProgressState()
                    }
                    return
                }
                
                if (try fileManager.contentsOfDirectory(atPath: "\(worldPath)/advancements").isEmpty || fileManager.contentsOfDirectory(atPath: "\(worldPath)/stats").isEmpty) {
                    if trackerManager.updateErrorAlert(alert: .invalidDirectory) {
                        progressManager.clearProgressState()
                    }
                    return
                }
                
                let fileName = try fileManager.contentsOfDirectory(atPath: "\(worldPath)/advancements")[0]
                let lastUpdate = try getModifiedTime("\(worldPath)/advancements/\(fileName)", fileManager: fileManager) ?? Date.now
                
                if (dataManager.lastModified != lastUpdate) {
                    dataManager.lastModified = lastUpdate
                    var advFileContents = try String(contentsOf: URL(fileURLWithPath: "\(worldPath)/advancements/\(fileName)"))
                    let advRange = NSRange(location: 0, length: advFileContents.count)
                    advFileContents = Constants.dataVersionRegex.stringByReplacingMatches(in: advFileContents, range: advRange, withTemplate: "")
                    
                    let advancements = try JSONDecoder().decode([String:JsonAdvancement].self, from: Data(advFileContents.utf8))
                    let statistics = try JSONDecoder().decode(JsonStats.self, from: Data(contentsOf: URL(fileURLWithPath: "\(worldPath)/stats/\(fileName)")))
                    let uuid = String(fileName.dropLast(5))
                    
                    playerManager.updatePlayerUUID(uuid: uuid)
                    progressManager.updateProgressState(advancements: advancements, statistics: statistics.stats)
                    trackerManager.updateErrorAlert(alert: .none)
                }
            } catch {
                print(error.localizedDescription)
            }
        } else {
            trackerManager.resetWorldPath()
            if (saves.isEmpty) {
                trackerManager.updateErrorAlert(alert: .noDirectory)
                return
            }
            trackerManager.updateErrorAlert(alert: .directoryNotFound)
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
                
                if let line = Utilities.readLastLine(ofFileAtPath: logFile), line.contains("Loaded") && line.contains("advancements") {
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
    
    private func getModifiedTime(_ filePath: String, fileManager: FileManager) throws -> Date? {
        try fileManager.attributesOfItem(atPath: filePath)[FileAttributeKey.modificationDate] as? Date
    }
    
    private func getInstanceInfo() -> (String, Version?)? {
        let workspace = NSWorkspace.shared
        let apps = workspace.runningApplications.filter { $0.activationPolicy == .regular }
        guard let currentApp = apps.first(where: { $0.isActive }) else { return nil }
        
        let pid = currentApp.processIdentifier
        if let info = activeWindows[pid] {
            return (info.0, info.1)
        }
        
        guard let arguments = Utilities.processArguments(pid: pid) else { return nil }
        let version = extractGameVersion(from: arguments)
        
        if let gameDirIndex = arguments.firstIndex(of: "--gameDir") {
            let info = "\(arguments[gameDirIndex + 1])/saves"
            activeWindows[pid] = (info, version)
            return (info, version)
        }
        
        if let nativesArg = arguments.first(where: { $0.starts(with: "-Djava.library.path=") }) {
            let info = "\(nativesArg.dropFirst(20).dropLast("natives".count)).minecraft/saves"
            activeWindows[pid] = (info, version)
            return (info, version)
        }
        
        activeWindows[pid] = ("", nil)
        return nil
    }
    
    private func extractGameVersion(from processArguments: [String]) -> Version? {
        if let gameVersionIndex = processArguments.firstIndex(of: "--version") {
            let baseVersion = processArguments[gameVersionIndex + 1].components(separatedBy: ".").prefix(2).joined(separator: ".")
            return Version(rawValue: baseVersion)
        }
        
        if let argument = processArguments.first(where: { Constants.versionRegex.firstMatch(in: $0, range: NSRange($0.startIndex..., in: $0)) != nil }),
           let match = Constants.versionRegex.firstMatch(in: argument, range: NSRange(argument.startIndex..., in: argument)),
           let range = Range(match.range(at: 1), in: argument) {
            let extractedVersion = String(argument[range])
            let baseVersion = extractedVersion.components(separatedBy: ".").prefix(2).joined(separator: ".")
            return Version(rawValue: baseVersion)
        }
        
        return nil
    }
}
