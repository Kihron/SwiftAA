//
//  UpdateSettings.swift
//  SwiftAA
//
//  Created by Kihron on 9/7/23.
//

import SwiftUI

struct UpdateSettings: View {
    @ObservedObject private var updateManager = UpdateManager.shared
    
    var body: some View {
        VStack {
            SettingsCardView {
                VStack {
                    SettingsToggleView(title: L10n.Settings.Updater.autoCheck, option: $updateManager.checkAutomatically)
                    
                    Divider()
                    
                    SettingsToggleView(title: L10n.Settings.Updater.autoDownload, option: $updateManager.downloadAutomatically)
                        .disabled(!updateManager.checkAutomatically)
                }
            }
            
            VStack {
                Text("SwiftAA \(updateManager.appVersion ?? "") (\(updateManager.appBuild ?? ""))")
                
                if let lastUpdateCheck = updateManager.getLastUpdateCheckDate() {
                    HStack(spacing: 0) {
                        Text(L10n.Settings.Updater.lastChecked)
                        
                        Text(lastUpdateCheck, formatter: updateManager.lastUpdateFormatter)
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
        .padding([.horizontal, .top])
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .onChange(of: updateManager.checkAutomatically) { value in
            updateManager.automaticallyCheckForUpdates = value
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { updateManager.checkForUpdates() }) {
                    Image(systemName: "arrow.clockwise")
                }
                .help(L10n.Settings.Updater.checkForUpdates)
            }
        }
    }
}

#Preview {
    UpdateSettings()
        .frame(width: 500, height: 600)
}
