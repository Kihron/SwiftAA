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
        VStack {
            HStack(spacing: 20) {
                VStack {
                    Text("tracking-game-version", comment: "Title: game version")
                        .font(.custom("Minecraft-Regular", size: 10))
                        .padding(.horizontal)
                    
                    Menu {
                        Button {
                            settings.gameVersion = "1.16"
                        } label: {
                            Text("1.16")
                                .font(.custom("Minecraft-Regular", size: 10))
                        }
                        Button {
                            settings.gameVersion = "1.19"
                        } label: {
                            Text("1.19")
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
            
            Text("tracking-attribution", comment: "Attribution message for CTM's AATool for Windows")
                .font(.custom("Minecraft-Regular", size: 12))
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
                .frame(width: 400)
        }
    }
}

struct TrackingSettingsView_Previews: PreviewProvider {
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        TrackingSettingsView()
            .frame(width: 500, height: 300)
            .environmentObject(settings)
    }
}
