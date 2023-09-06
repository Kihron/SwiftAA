//
//  SwiftAAViewModel.swift
//  SwiftAA
//
//  Created by Kihron on 1/2/23.
//

import SwiftUI

class AppViewModel: ObservableObject {    
    @ObservedObject var settings = AppSettings()
    @ObservedObject var dataManager = DataManager.shared
    @ObservedObject var trackerManager = TrackerManager.shared
    @ObservedObject var updater = Updater()
    
    @Published var advancementsUpdated: Bool = false
    @Published var error: String = ""
    
    private var lastWorking = ""
    private var lastDirectoryUpdate: Date? = Date.now
    private var lastLogUpdate: Date? = Date.now
    private var activeWindows = [pid_t:String]()
    private var wasCleared: Bool = true
    private var uuid = ""
    
    private let regex = try! NSRegularExpression(pattern: ",\\s*\"DataVersion\"\\s*:\\s*\\d*|\"DataVersion\"\\s*:\\s*\\d*\\s*,?")
    
    func onAppear() {
        settings.lastUpdateCheck = updater.getLastUpdateCheckDate()
        settings.player = nil
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            withAnimation {
                self.error = self.refreshData()
            }
        }
    }
    
    func refreshData() -> String {
        advancementsUpdated = false
        let saves: String
        if (trackerManager.trackingMode == .directory) {
            saves = trackerManager.customSavesPath
        } else {
            let dir = getSavesFromActiveInstance()
            if (dir.count <= 0) {
                saves = lastWorking
                if (saves.count <= 0) {
                    updateAll()
                    return L10n.Error.enterMinecraft
                }
            } else {
                saves = dir
                if (saves != lastWorking) {
                    lastWorking = saves
                }
            }
        }
        
        let fileManager = FileManager.default
        if (fileManager.fileExists(atPath: saves)) {
            do {
                let savesDirectoryUpdated = try getModifiedTime(saves, fileManager: fileManager)
                var world: String
                
                let logFile = "\(saves.dropLast(5))/logs/latest.log"
                let logUpdated = try getModifiedTime(logFile, fileManager: fileManager)
                
                var isNewWorld = false
                if (lastLogUpdate != logUpdated) {
                    lastLogUpdate = logUpdated
                    let log = try String(contentsOfFile: logFile, encoding: .utf8).components(separatedBy: .newlines)
                    let lastLine = log[log.count - 2]
                    if (lastLine.contains("Loaded") && lastLine.contains("advancements")) {
                        isNewWorld = true
                    }
                }
                
                if (lastDirectoryUpdate != savesDirectoryUpdated || isNewWorld) {
                    lastDirectoryUpdate = savesDirectoryUpdated
                    isNewWorld = false
                    let contents = try fileManager.contentsOfDirectory(atPath: saves).filter({ folder in
                        folder != ".DS_Store"
                    })
                    if (contents.isEmpty) {
                        updateAll()
                        return "No Worlds Found"
                    }
                    
                    world = try contents.max { a, b in
                        let date1 = try getModifiedTime("\(saves)/\(a)", fileManager: fileManager)
                        let date2 = try getModifiedTime("\(saves)/\(b)", fileManager: fileManager)
                        return date1?.compare(date2!) == ComparisonResult.orderedAscending
                    }!
                    
                    world = "\(saves)/\(world)"
                    settings.worldPath = world
                } else {
                    world = settings.worldPath
                }
                
                if (!["advancements", "stats"].allSatisfy(try fileManager.contentsOfDirectory(atPath: world).contains)) {
                    updateAll()
                    return ""
                }
                
                if (try fileManager.contentsOfDirectory(atPath: "\(world)/advancements").isEmpty || fileManager.contentsOfDirectory(atPath: "\(world)/stats").isEmpty) {
                    updateAll()
                    return "Invalid Directory"
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
                    
                    uuid = String(fileName.dropLast(5))
                    Task {
                        let player = await getPlayer()
                        if (player != settings.player) {
                            settings.player = player
                        }
                    }
                    
                    updateAll(advancements: advancements, statistics: statistics.stats)
                }
                
            } catch let error {
                print(error)
            }
        } else {
            if (saves.isEmpty) {
                updateAll()
                return "No Directory Selected"
            }
            updateAll()
            return "Directory Not Found"
        }
        return ""
    }
    
    func getPlayer() async -> Player {
        do {
            let url = URL(string: "https://api.mojang.com/user/profile/\(uuid)")!
            let player = try await URLSession.shared.decode(Player.self, from: url)
            return player
        } catch {
            print(error.localizedDescription)
            return Player(id: "", name: "")
        }
    }
    
    func getModifiedTime(_ filePath: String, fileManager: FileManager) throws -> Date? {
        try fileManager.attributesOfItem(atPath: filePath)[FileAttributeKey.modificationDate] as? Date
    }
    
    func getSavesFromActiveInstance() -> String {
        let workspace = NSWorkspace.shared
        let apps = workspace.runningApplications.filter{  $0.activationPolicy == .regular }
        if let currentApp = apps.first(where: {$0.isActive}) {
            let pid = currentApp.processIdentifier
            if let path = activeWindows[pid] {
                return path
            }
            
            if let arguments = dataManager.processArguments(pid: pid) {
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
        return ""
    }
    
    func updateAll(advancements: [String:JsonAdvancement] = [:], statistics: [String:[String:Int]] = [:]) {
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
        
        let timeStat = TrackerManager.shared.gameVersion == .v1_16 ? "minecraft:play_one_minute" : "minecraft:play_time"
        
        dataManager.statsData = statistics
        dataManager.playTime = statistics["minecraft:custom"]?[timeStat] ?? 0
        dataManager.allAdvancements = dataManager.map.values.flatMap({$0}).filter({$0.completed}).count >= dataManager.map.values.compactMap({$0.count}).reduce(0, +)
        
        advancementsUpdated = true
    }
}
