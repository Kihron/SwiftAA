//
//  TrackingSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 7/21/22.
//

import SwiftUI

struct TrackingSettingsView: View {
    @ObservedObject var dataHandler: DataHandler
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                VStack {
                    Text("tracking-game-version", comment: "Title: game version")
                        .font(.custom("Minecraft-Regular", size: 10))
                        .padding(.horizontal)
                    
                    Menu {
                        Button {
                            if (settings.gameVersion != "1.19") {
                                settings.gameVersion = "1.19"
                                Task {
                                    dataHandler.removeOldVersion(gameVersion: settings.gameVersion)
                                }
                            }
                        } label: {
                            Text("1.19")
                                .font(.custom("Minecraft-Regular", size: 10))
                        }
                        Button {
                            if (settings.gameVersion != "1.16") {
                                settings.gameVersion = "1.16"
                                Task {
                                    dataHandler.removeOldVersion(gameVersion: settings.gameVersion)
                                }
                            }
                        } label: {
                            Text("1.16")
                                .font(.custom("Minecraft-Regular", size: 10))
                        }
                    } label: {
                        Text(settings.gameVersion)
                            .font(.custom("Minecraft-Regular", size: 10))
                   }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .frame(width: 100)
                
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Picker(selection: settings.$trackingMode, label: Text("")) {
                                Group {
                                    Text("tracking-seamless", comment: "title: automatically tracks active instance")
                                        .font(.custom("Minecraft-Regular", size: 10))
                                }
                                .tag(TrackingMode.seamless)
                                .padding(.bottom)
                                
                                Group {
                                    VStack(alignment: .leading) {
                                        Text("tracking-custom-saves", comment: "Title: custom user defined saves directory")
                                            .font(.custom("Minecraft-Regular", size: 10))
                                        
                                        HStack {
                                            TextField("tracking-enter-directory", text: $settings.customSavesPath)
                                                .font(.custom("Minecraft-Regular", size: 10))
                                                .textFieldStyle(.roundedBorder)
                                            
                                            
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
                                                Text("tracking-browse", comment: "Button: browse to select folder")
                                                    .font(.custom("Minecraft-Regular", size: 10))
                                            }
                                            
                                        }
                                        .padding(.trailing)
                                    }
                                }
                                .tag(TrackingMode.directory)
                            }.pickerStyle(.radioGroup)
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom)
                }
            }
            .padding(.top)
            
            Spacer()
                
            DonationView()
                .padding(.bottom, 10)
            
            Text("tracking-attribution", comment: "Attribution message for CTM's AATool for Windows")
                .font(.custom("Minecraft-Regular", size: 12))
                .multilineTextAlignment(.center)
                .frame(width: 400)
                .padding(.trailing)
                .padding(.bottom, 10)
        }
    }
}

struct TrackingSettingsView_Previews: PreviewProvider {
    @ObservedObject static var dataHandler = DataHandler()
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        TrackingSettingsView(dataHandler: dataHandler)
            .frame(width: 450, height: 300)
            .environmentObject(settings)
    }
}
