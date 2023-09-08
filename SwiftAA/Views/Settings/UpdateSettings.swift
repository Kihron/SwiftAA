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
                    HStack {
                        Text("Check Automatically")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Toggle("", isOn: $updateManager.checkAutomatically)
                            .labelsHidden()
                            .toggleStyle(.switch)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Download Automatically")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Toggle("", isOn: $updateManager.downloadAutomatically)
                            .labelsHidden()
                            .toggleStyle(.switch)
                    }
                    .disabled(!updateManager.checkAutomatically)
                }
            }
            
            VStack {
                Text("SwiftAA \(updateManager.appVersion ?? "")")
                
                if let lastUpdateCheck = updateManager.getLastUpdateCheckDate() {
                    HStack(spacing: 0) {
                        Text("Last checked: ")
                        
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
            }
        }
    }
}

#Preview {
    UpdateSettings()
        .frame(width: 500, height: 600)
}
