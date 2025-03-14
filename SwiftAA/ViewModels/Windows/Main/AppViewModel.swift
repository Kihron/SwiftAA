//
//  SwiftAAViewModel.swift
//  SwiftAA
//
//  Created by Kihron on 1/2/23.
//

import SwiftUI

class AppViewModel: ObservableObject {
    private var dataManager = DataManager.shared
    private var progressManager = ProgressManager.shared
    private var playerManager = PlayerManager.shared
    private var trackerManager = TrackerManager.shared
    
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
                
                if (saves != trackerManager.lastWorking) {
                    trackerManager.lastWorking = saves
                }
                
                if let version = info.1, trackerManager.automaticVersionDetection {
                    if trackerManager.updateGameVersion(version: version) {
                        return
                    }
                }
            } else {
                saves = trackerManager.lastWorking
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
                let worldPath = getWorldPath(fileManager: fileManager, saves: saves) ?? trackerManager.worldPath
                guard !worldPath.isEmpty else { return }
                
                if (!["advancements", "stats"].allSatisfy(try fileManager.contentsOfDirectory(atPath: worldPath).contains)) {
                    if trackerManager.updateErrorAlert(alert: .noFiles) {
                        progressManager.clearProgressState()
                    }
                    return
                }

                let files = try fileManager.contentsOfDirectory(atPath: "\(worldPath)/advancements")
                let stats = try fileManager.contentsOfDirectory(atPath: "\(worldPath)/stats")

                if (files.isEmpty || stats.isEmpty) {
                    if trackerManager.updateErrorAlert(alert: .invalidDirectory) {
                        progressManager.clearProgressState()
                    }
                    return
                }

                let fileName = playerManager.player.flatMap({ player in files.first(where: { $0.replacingOccurrences(of: "-", with: "") == "\(player.id).json" })}) ?? files[0]
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
                    playerManager.updateAvailablePlayers(uuids: files.map({ ($0 as NSString).deletingPathExtension }))
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
    
    private func getWorldPath(fileManager: FileManager, saves: String) -> String? {
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
                    if trackerManager.updateErrorAlert(alert: .noWorlds) {
                        trackerManager.resetWorldPath()
                    }
                    return nil
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
                return nil
            }
        } catch {
            print(error.localizedDescription)
            return nil
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
            let basePath = nativesArg.dropFirst(20).replacingOccurrences(of: "natives", with: "")
            let possiblePaths = ["\(basePath).minecraft/saves", "\(basePath)/minecraft/saves"]

            if let validPath = possiblePaths.first(where: { fileManager.fileExists(atPath: $0) }) {
                activeWindows[pid] = (validPath, version)
                return (validPath, version)
            }
        }
        
        activeWindows[pid] = ("", nil)
        return nil
    }
    
    private func extractGameVersion(from processArguments: [String]) -> Version? {
        if let extractedVersion = extractGameVersionString(from: processArguments) {
            let baseVersion = extractedVersion.components(separatedBy: ".").prefix(2).joined(separator: ".")
            return Version(rawValue: extractedVersion) ?? Version(rawValue: baseVersion)
        }
        
        return nil
    }
    
    private func extractGameVersionString(from processArguments: [String]) -> String? {
        for (index, argument) in processArguments.enumerated() {
            if argument == "--version", index + 1 < processArguments.count {
                return processArguments[index + 1]
            } else if let match = Constants.versionRegex.firstMatch(in: argument, range: NSRange(argument.startIndex..., in: argument)), let range = Range(match.range(at: 1), in: argument) {
                return String(argument[range])
            }
        }
        
        return nil
    }
}
