//
//  TrackingSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 7/21/22.
//

import SwiftUI

struct TrackingSettingsView: View {
    @ObservedObject var dataManager: DataManager
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                VStack {
                    Text(L10n.Tracking.Game.version)
                        .font(.custom("Minecraft-Regular", size: 10))
                        .padding(.horizontal)
                    
//                    Menu {
//                        Button {
//                            if (settings.gameVersion != "1.19") {
//                                settings.gameVersion = "1.19"
//                                Task {
//                                    dataManager.removeOldVersion(gameVersion: settings.gameVersion)
//                                }
//                            }
//                        } label: {
//                            Text("1.19")
//                                .font(.custom("Minecraft-Regular", size: 10))
//                        }
//                        Button {
//                            if (settings.gameVersion != "1.16") {
//                                settings.gameVersion = "1.16"
//                                Task {
//                                    dataManager.removeOldVersion(gameVersion: settings.gameVersion)
//                                }
//                            }
//                        } label: {
//                            Text("1.16")
//                                .font(.custom("Minecraft-Regular", size: 10))
//                        }
//                    } label: {
//                        Text(settings.gameVersion)
//                            .font(.custom("Minecraft-Regular", size: 10))
//                    }
//                    .padding(.horizontal)
                }
                .frame(width: 100)
                .frame(maxHeight: .infinity, alignment: .top)
                
//                VStack(alignment: .leading) {
//                    Picker(selection: settings.$trackingMode, label: Text("")) {
//                        Group {
//                            Text(L10n.Tracking.seamless)
//                                .font(.custom("Minecraft-Regular", size: 10))
//                        }
//                        .tag(TrackingMode.seamless)
//                        .padding(.bottom)
//                        
//                        Group {
//                            VStack(alignment: .leading) {
//                                Text(L10n.Tracking.Custom.saves)
//                                    .font(.custom("Minecraft-Regular", size: 10))
//                                
//                                HStack {
//                                    TextField(L10n.Tracking.Enter.directory, text: $settings.customSavesPath)
//                                        .font(.custom("Minecraft-Regular", size: 10))
//                                        .textFieldStyle(.roundedBorder)
//                                    
//                                    
//                                    Button {
//                                        let panel = NSOpenPanel()
//                                        panel.allowsMultipleSelection = false
//                                        panel.canChooseDirectories = true
//                                        panel.canChooseFiles = false
//                                        if panel.runModal() == .OK {
//                                            settings.customSavesPath = panel.url?.path ?? ""
//                                        }
//                                        NSApp.keyWindow?.makeFirstResponder(nil)
//                                    } label: {
//                                        Text(L10n.Tracking.browse)
//                                            .font(.custom("Minecraft-Regular", size: 10))
//                                    }
//                                    
//                                }
//                                .padding(.trailing)
//                            }
//                        }
//                        .tag(TrackingMode.directory)
//                    }.pickerStyle(.radioGroup)
//                }
//                .frame(maxHeight: .infinity, alignment: .top)
//                .padding(.bottom)
            }
            .padding(.top)
            
            Spacer()
            
            DonationView()
                .padding(.bottom, 10)
            
            Text(L10n.Tracking.attribution)
                .font(.custom("Minecraft-Regular", size: 12))
                .multilineTextAlignment(.center)
                .frame(width: 400)
                .padding(.trailing)
                .padding(.bottom, 10)
        }
    }
}

struct TrackingSettingsView_Previews: PreviewProvider {
    @ObservedObject static var dataManager = DataManager()
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        TrackingSettingsView(dataManager: dataManager)
            .frame(width: 450, height: 300)
            .environmentObject(settings)
    }
}
