//
//  Updater.swift
//  SwiftAA
//
//  Created by Kihron on 8/19/22.
//

import SwiftUI
import Sparkle

// This view model class manages Sparkle's updater and publishes when new updates are allowed to be checked
final class Updater: ObservableObject {
    private let updaterController: SPUStandardUpdaterController
    
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
    @ObservedObject var updater: Updater
    
    var body: some View {
        Button("Check for Updates…", action: updater.checkForUpdates)
            .disabled(!updater.canCheckForUpdates)
    }
}

struct CheckForUpdatesViewView_Preview: PreviewProvider {
    @ObservedObject static var updater = Updater()

    static var previews: some View {
        CheckForUpdatesView(updater: updater)
    }
}
