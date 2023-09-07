//
//  UpdateSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 8/19/22.
//

import SwiftUI

struct UpdateSettingsView: View {
    @ObservedObject private var updateManager = UpdateManager.shared
    
    static let lastUpdateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 0) {
                Image(nsImage: NSImage(named: "AppIcon") ?? NSImage())
                
                Text(L10n.App.title)
                    .font(.custom("Minecraft-Regular", size: 14))
                
                Text("v\(appVersion!)")
                    .font(.custom("Minecraft-Regular", size: 12))
            }
            
            VStack(spacing: 24) {
                Toggle(isOn: $updateManager.checkAutomatically, label: {
                    Text(L10n.Settings.Updater.Auto.check)
                        .font(.custom("Minecraft-Regular", size: 12))
                        .multilineTextAlignment(.center)
                })
                
                VStack {
                    Button(action: {
                        updateManager.checkForUpdates()
                        // There's a delay between requesting an update, and the timestamp for that update request being
                        // written to user defaults; we therefore delay updating the "Last checked" UI for one second.
                    }, label: {
                        Text(L10n.Settings.Updater.check)
                            .font(.custom("Minecraft-Regular", size: 12))
                    })
                    
                    HStack(spacing: 5) {
                        Text(L10n.Settings.Updater.Last.checked)
                            .font(.custom("Minecraft-Regular", size: 10))
                        
                        if let lastUpdateCheck = updateManager.getLastUpdateCheckDate() {
                            Text(lastUpdateCheck, formatter: Self.lastUpdateFormatter)
                                .font(.custom("Minecraft-Regular", size: 10))
                        } else {
                            Text(L10n.never)
                                .font(.custom("Minecraft-Regular", size: 10))
                        }
                    }
                }
            }
        }
        .onChange(of: updateManager.checkAutomatically) { value in
            updateManager.automaticallyCheckForUpdates = value
        }
    }
}

struct UpdateSettingsView_Previews: PreviewProvider {
    @ObservedObject static var updater = UpdateManager.shared
    
    static var previews: some View {
        UpdateSettingsView()
            .frame(width: 500, height: 300)
    }
}
