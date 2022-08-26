//
//  SwiftAAApp.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI

@main
struct SwiftAAApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var settings = AppSettings()
    @ObservedObject var dataHandler = DataHandler()
    @ObservedObject var updater = Updater()
    @Environment(\.openURL) var openURL
    
    @State var changed: Bool = false
    @State var windowTitle = "SwiftAA"
    @State var wasCleared: Bool = true
    @State var lastDirectoryUpdate: Date? = Date.now
    @State var lastLogUpdate: Date? = Date.now
    @State var error = ""
    
    @State var activeWindows = [pid_t:String]()
    @State var lastWorking = ""
    
    @State var uuid = ""
    
    let regex = try! NSRegularExpression(pattern: ",\\s*\"DataVersion\"\\s*:\\s*\\d*|\"DataVersion\"\\s*:\\s*\\d*\\s*,?")
    
    var body: some Scene {
        WindowGroup("SwiftAA") {
            ContentView(dataHandler: dataHandler, changed: $changed)
                .applyVersionFrame(gameVersion: settings.$gameVersion)
                .onAppear {
                    settings.lastUpdateCheck = updater.getLastUpdateCheckDate()
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
                        withAnimation {
                            error = refreshData()
                        }
                    }
                }
                .navigationTitle(windowTitle)
                .toolbar {
                    ToolbarItem(placement: .status) {
                        ToolbarRefreshView(visible: $changed)
                    }
                    ToolbarItem(placement: .status) {
                        ToolbarPlayerHead()
                    }
                    ToolbarItem(placement: .status) {
                        ToolbarAAView(dataHandler: dataHandler, changed: $changed)
                    }
                    ToolbarItem(placement: .status) {
                        if (!error.isEmpty) {
                            ToolbarAlertView(error: $error)
                        }
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification), perform: { _ in
                    for window in NSApplication.shared.windows {
                        window.standardWindowButton(.zoomButton)?.isEnabled = false
                    }
                })
                .removeFocusOnTap()
                .preferredColorScheme(.dark)
                .environmentObject(settings)
        }
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("about-button".localized) {
                    NSApplication.shared.orderFrontStandardAboutPanel(
                        options: [
                            NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                                string: "about-description".localized,
                                attributes: [
                                    NSAttributedString.Key.font: NSFont.boldSystemFont(
                                        ofSize: NSFont.smallSystemFontSize)
                                ]
                            ),
                            NSApplication.AboutPanelOptionKey(
                                rawValue: "Copyright"
                            ): "about-copyright".localized
                        ]
                    )
                }
            }
            CommandGroup(after: .appInfo, addition: {
                Button("\("settings-updater-check".localized)...") {
                    updater.checkForUpdates()
                }
            })
        }
        
        WindowGroup("Overlay") {
            OverlayView(dataHandler: dataHandler)
                .frame(minWidth: settings.overlayLoaded ? (!dataHandler.allAdvancements ? 400 : 825) : settings.overlayWidth, maxWidth: settings.overlayLoaded ? .infinity : settings.overlayWidth, minHeight: 345, maxHeight: 345, alignment: .center)
                .environmentObject(settings)
                .onAppear {
                    settings.overlayLoaded = true
                    Task {
                        let windows = NSApplication.shared.windows.filter({ window in
                            window.title == "Overlay"
                        })
                        windows.first!.standardWindowButton(NSWindow.ButtonType.closeButton)!.isEnabled = false
                    }
                }
                .onDisappear {
                    settings.overlayLoaded = false
                }
        }.commands {
            CommandGroup(after: .sidebar, addition: {
                Button {
                    let windows = NSApplication.shared.windows.filter({ window in
                        window.title == "Overlay"
                    })
                    
                    if (windows.isEmpty) {
                        if let url = URL(string: "SwiftAA://Overlay") {
                            openURL(url)
                        }
                    } else {
                        settings.overlayWidth = Double(windows.first!.frame.width)
                        windows.first!.close()
                    }
                } label: {
                    Text("overlay-toggle", comment: "Button: shows/hides overlay")
                }
                .keyboardShortcut("o")
            })
            
            CommandGroup(replacing: .newItem, addition: {})
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: "Overlay"))
        .windowStyle(HiddenTitleBarWindowStyle())
        
        Settings {
            SettingsView(dataHandler: dataHandler, updater: updater)
                .environmentObject(settings)
        }
    }
    
    func refreshData() -> String {
        let saves: String
        if (settings.trackingMode == .directory) {
            saves = settings.customSavesPath
        } else {
            let dir = getSavesFromActiveInstance()
            if (dir.count <= 0) {
                saves = lastWorking
                if (saves.count <= 0) {
                    updateAll()
                    return "error-enter-minecraft"
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
                
                if (dataHandler.lastModified != lastUpdate) {
                    dataHandler.lastModified = lastUpdate
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
            return try await URLSession.shared.decode(Player.self, from: url)
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
            if let arguments = dataHandler.processArguments(pid: pid) {
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
            dataHandler.lastModified = Date.now
        } else {
            wasCleared = false
        }
        
        let flatMap = dataHandler.map.values.flatMap({$0})
        flatMap.forEach { adv in
            adv.update(advancements: advancements, stats: statistics)
        }
        
        dataHandler.stats.forEach { stat in
            stat.update(advancements: advancements, stats: statistics)
        }
        
        let timeStat = settings.gameVersion == "1.16" ? "minecraft:play_one_minute" : "minecraft:play_time"
        
        dataHandler.statsData = statistics
        dataHandler.playTime = statistics["minecraft:custom"]?[timeStat] ?? 0
        dataHandler.allAdvancements = dataHandler.map.values.flatMap({$0}).filter({$0.completed}).count >= dataHandler.map.values.compactMap({$0.count}).reduce(0, +)
        
        changed = true
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false
    }
}
