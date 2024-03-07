//
//  UpdateManager.swift
//  SwiftAA
//
//  Created by Kihron on 8/19/22.
//

import SwiftUI
import Sparkle

// This view model class manages Sparkle's updater and publishes when new updates are allowed to be checked
final class UpdateManager: ObservableObject {
    @AppStorage("checkAutomatically") var checkAutomatically: Bool = true
    @AppStorage("downloadAutomatically") var downloadAutomatically: Bool = true
    
    private let updaterController: SPUStandardUpdaterController
    
    static let shared = UpdateManager()
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    
    @Published var canCheckForUpdates = false
    
    var automaticallyCheckForUpdates: Bool {
        get {
            let isAutomatic = updaterController.updater.automaticallyChecksForUpdates
            UserDefaults.standard.set(isAutomatic, forKey: "checkAutomatically")
            return isAutomatic
        }
        set(newValue) {
            updaterController.updater.automaticallyChecksForUpdates = newValue
        }
    }
    
    var automaticallyDownloadUpdates: Bool {
        get {
            let isAutomatic = updaterController.updater.automaticallyDownloadsUpdates
            UserDefaults.standard.set(isAutomatic, forKey: "downloadAutomatically")
            return isAutomatic
        }
        set(newValue) {
            updaterController.updater.automaticallyDownloadsUpdates = newValue
        }
    }
    
    let lastUpdateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    init() {
        // If you want to start the updater manually, pass false to startingUpdater and call .startUpdater() later
        // This is where you can also pass an updater delegate if you need one
        updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
        
        updaterController.updater.publisher(for: \.canCheckForUpdates)
            .assign(to: &$canCheckForUpdates)
        
        if automaticallyCheckForUpdates {
            updaterController.updater.checkForUpdatesInBackground()
        }
    }
    
    func checkForUpdates() {
        updaterController.checkForUpdates(nil)
    }
    
    func getLastUpdateCheckDate() -> Date? {
        return updaterController.updater.lastUpdateCheckDate
    }
}

struct CheckForUpdatesView: View {
    @ObservedObject var updateManager: UpdateManager
    
    var body: some View {
        Button("Check for Updates…", action: updateManager.checkForUpdates)
            .disabled(!updateManager.canCheckForUpdates)
    }
}

struct CheckForUpdatesViewView_Preview: PreviewProvider {
    @ObservedObject static var updater = UpdateManager()

    static var previews: some View {
        CheckForUpdatesView(updateManager: updater)
    }
}
