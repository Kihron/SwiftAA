//
//  TrackingSettingsView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/21/22.
//

import SwiftUI

struct TrackingSettingsView: View {
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Text("Game Version")
                    .font(.custom("Minecraft-Regular", size: 10))
                
                Menu {
                    Button {
                        settings.gameVersion = "1.16"
                    } label: {
                        Text("1.16")
                    }
                } label: {
                    Text(settings.gameVersion)
                        .font(.custom("Minecraft-Regular", size: 10))
               }
                .padding(.horizontal)
            }
            .frame(width: 100)
            
            VStack(alignment: .leading) {
                Text("Custom Saves Folder")
                    .font(.custom("Minecraft-Regular", size: 10))
                
                HStack {
                    TextField("Enter Directory", text: $settings.customSavesPath)
                        .textFieldStyle(.roundedBorder)
                        .font(.custom("Minecraft-Regular", size: 10))
                    
                    Button {
                        let panel = NSOpenPanel()
                        panel.allowsMultipleSelection = false
                        panel.canChooseDirectories = true
                        panel.canChooseFiles = false
                        if panel.runModal() == .OK {
                            settings.customSavesPath = panel.url?.path ?? ""
                        }
                        NSApp.keyWindow?.makeFirstResponder(nil)
                    } label: {
                        Text("Browse")
                            .font(.custom("Minecraft-Regular", size: 10))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct TrackingSettingsView_Previews: PreviewProvider {
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        TrackingSettingsView()
            .frame(width: 450, height: 250)
            .environmentObject(settings)
    }
}
