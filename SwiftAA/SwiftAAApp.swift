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
    @Environment(\.openURL) var openURL
    
    @State var changed: Bool = false
    @State var windowTitle = "SwiftAA"
    @State var lastModified = Date.now
    @State var wasCleared: Bool = true
    @State var error = ""
    
    @State var activeWindows = [pid_t:String]()
    @State var lastWorking = ""
    
    let regex = try! NSRegularExpression(pattern: ",\\s*\"DataVersion\"\\s*:\\s*\\d*|\"DataVersion\"\\s*:\\s*\\d*\\s*,?")
    
    var body: some Scene {
        WindowGroup("SwiftAA") {
            ContentView(dataHandler: dataHandler, refresh: false, changed: $changed)
                .frame(minWidth: 350, idealWidth: 1431, maxWidth: 1431, minHeight: 260, idealHeight: 754, maxHeight: 754, alignment: .center)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
                        error = self.refreshData()
                    }
                }
                .navigationTitle(windowTitle)
                .toolbar {
                    ToolbarItem(placement: .status) {
                        ToolbarRefreshView(visible: $changed)
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
        }
        
        WindowGroup("OverlayWindow") {
            OverlayView(dataHandler: dataHandler)
                .frame(minWidth: !dataHandler.allAdvancements ? 400 : 785, idealWidth: 800, maxWidth: 1000, minHeight: 354, maxHeight: 354, alignment: .center)
                .environmentObject(settings)
        }.commands {
            CommandGroup(after: .sidebar, addition: {
                Button {
                    let windows = NSApplication.shared.windows.filter({ window in
                        window.title == "OverlayWindow"
                    })
                    
                    if (windows.isEmpty) {
                        if let url = URL(string: "SwiftAA://OverlayWindow") {
                            openURL(url)
                        }
                    } else {
                        windows.first!.close()
                    }
                } label: {
                    Text("overlay-toggle", comment: "Button: shows/hides overlay")
                }
                .keyboardShortcut("o")
            })
            
            CommandGroup(replacing: .newItem, addition: {})
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: "OverlayWindow"))
        .windowStyle(HiddenTitleBarWindowStyle())
        
        Settings {
            SettingsView()
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
                    return "Tab into Minecraft to start tracking"
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
                
                let contents = try fileManager.contentsOfDirectory(atPath: saves).filter({ folder in
                    return folder != ".DS_Store"
                })
                if (contents.isEmpty) {
                    updateAll()
                    return "No Worlds Found"
                }
                var world = try contents.max { a, b in
                    let date1 = try getModifiedTime("\(saves)/\(a)", fileManager: fileManager)
                    let date2 = try getModifiedTime("\(saves)/\(b)", fileManager: fileManager)
                    return date1?.compare(date2!) == ComparisonResult.orderedAscending
                }!
                world = "\(saves)/\(world)"
                if (!["advancements", "stats"].allSatisfy(try fileManager.contentsOfDirectory(atPath: world).contains)) {
                    updateAll()
                    return "Invalid Directory"
                }
                
                if (try fileManager.contentsOfDirectory(atPath: "\(world)/advancements").isEmpty || fileManager.contentsOfDirectory(atPath: "\(world)/stats").isEmpty) {
                    updateAll()
                    return "Invalid Directory"
                }
                
                settings.worldPath = world
                let fileName = try fileManager.contentsOfDirectory(atPath: "\(world)/advancements")[0]
                let lastUpdate = try getModifiedTime("\(world)/advancements/\(fileName)", fileManager: fileManager) ?? Date.now
                
                if (lastModified != lastUpdate) {
                    lastModified = lastUpdate
                    var advFileContents = try String(contentsOf: URL(fileURLWithPath: "\(world)/advancements/\(fileName)"))
                    let advRange = NSRange(location: 0, length: advFileContents.count)
                    advFileContents = regex.stringByReplacingMatches(in: advFileContents, range: advRange, withTemplate: "")
                    
                    let advancements = try JSONDecoder().decode([String:JsonAdvancement].self, from: Data(advFileContents.utf8))
                    let statistics = try JSONDecoder().decode(JsonStats.self, from: Data(contentsOf: URL(fileURLWithPath: "\(world)/stats/\(fileName)")))
                    
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
    
    func getModifiedTime(_ filePath: String, fileManager: FileManager) throws -> Date? {
        return try fileManager.attributesOfItem(atPath: filePath)[FileAttributeKey.modificationDate] as? Date
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
            lastModified = Date.now
        } else {
            wasCleared = false
        }
        
        let flatMap = dataHandler.map.values.flatMap({$0})
        flatMap.forEach { adv in
            adv.update(advancements: advancements, stats: statistics)
        }
        
        var stats = dataHandler.topStats
        stats.append(contentsOf: dataHandler.bottomStats)
        stats.forEach { stat in
            stat.update(advancements: advancements, stats: statistics)
        }
        
        withAnimation(.linear(duration: 0.5)) {
            dataHandler.playTime = statistics["minecraft:custom"]?["minecraft:play_one_minute"] ?? 0
            dataHandler.allAdvancements = dataHandler.map.values.flatMap({$0}).filter({$0.completed}).count == dataHandler.map.values.compactMap({$0.count}).reduce(0, +)
        }
        
        changed = true
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false
    }
}
