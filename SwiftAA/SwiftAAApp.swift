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
    
    @State var changed: Bool = false
    @State var windowTitle = "SwiftAA"
    @State var lastModified = Date.now
    
    let regex = try! NSRegularExpression(pattern: ",\\s*\"DataVersion\"\\s*:\\s*\\d*|\"DataVersion\"\\s*:\\s*\\d*\\s*,?")
    
    var body: some Scene {
        WindowGroup {
            ContentView(dataHandler: dataHandler, refresh: false, changed: $changed)
                .frame(minWidth: 350, idealWidth: 1431, maxWidth: 1431, minHeight: 775, maxHeight: 775, alignment: .center)
                .onAppear {
                    settings.load()
                    
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
                        windowTitle = "SwiftAA\(self.refreshData())"
                    }
                    
                    NotificationCenter.default.addObserver(forName: NSApplication.willTerminateNotification, object: nil, queue: .main) { _ in
                        settings.save()
                    }
                }
                .navigationTitle(windowTitle)
                .environmentObject(settings)
        }
        
        Settings {
            SettingsView()
                .environmentObject(settings)
        }
    }
    
    func refreshData() -> String {
        let saves = settings.customSavesPath
        let fileManager = FileManager.default
        if (fileManager.fileExists(atPath: saves)) {
            do {
                let contents = try fileManager.contentsOfDirectory(atPath: saves).filter({ folder in
                    return folder != ".DS_Store"
                })
                if (contents.isEmpty) {
                    return " - No Worlds Found"
                }
                var world = try contents.max { a, b in
                    let date1 = try getModifiedTime("\(saves)/\(a)", fileManager: fileManager)
                    let date2 = try getModifiedTime("\(saves)/\(b)", fileManager: fileManager)
                    return date1?.compare(date2!) == ComparisonResult.orderedAscending
                }!
                world = "\(saves)/\(world)"
                if (!["advancements", "stats"].allSatisfy(try fileManager.contentsOfDirectory(atPath: world).contains)) {
                    return " - Invalid Directory"
                }
                
                if (try fileManager.contentsOfDirectory(atPath: "\(world)/advancements").isEmpty || fileManager.contentsOfDirectory(atPath: "\(world)/stats").isEmpty) {
                    return " - Invalid Directory"
                }
                
                let fileName = try fileManager.contentsOfDirectory(atPath: "\(world)/advancements")[0]
                let lastUpdate = try getModifiedTime("\(world)/advancements/\(fileName)", fileManager: fileManager) ?? Date.now
                
                if (lastModified != lastUpdate) {
                    lastModified = lastUpdate
                    var advFileContents = try String(contentsOf: URL(fileURLWithPath: "\(world)/advancements/\(fileName)"))
                    let advRange = NSRange(location: 0, length: advFileContents.count)
                    advFileContents = regex.stringByReplacingMatches(in: advFileContents, range: advRange, withTemplate: "")
                    
                    let advancements = try JSONDecoder().decode([String:JsonAdvancement].self, from: Data(advFileContents.utf8))
                    let statistics = try JSONDecoder().decode(JsonStats.self, from: Data(contentsOf: URL(fileURLWithPath: "\(world)/stats/\(fileName)")))
                    
                    let flatMap = dataHandler.map.values.flatMap({$0})
                    flatMap.forEach { adv in
                        adv.update(advancements: advancements, stats: statistics.stats)
                    }
                    
                    var stats = dataHandler.topStats
                    stats.append(contentsOf: dataHandler.bottomStats)
                    stats.forEach { stat in
                        stat.update(advancements: advancements, stats: statistics.stats)
                    }
                    
                    changed = true
                }
                
            } catch let error {
                print(error)
            }
        } else {
            if (saves.isEmpty) {
                return " - No Directory Selected"
            }
            return " - Directory Not Found"
        }
        return ""
    }
    
    func getModifiedTime(_ filePath: String, fileManager: FileManager) throws -> Date? {
        return try fileManager.attributesOfItem(atPath: filePath)[FileAttributeKey.modificationDate] as? Date
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
