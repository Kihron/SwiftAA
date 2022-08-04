//
//  ThemeSettingsView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/21/22.
//

import SwiftUI

struct ThemeSettingsView: View {
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Picker(selection: settings.$themeMode, label: Text("")) {
                    Group {
                        VStack(alignment: .leading) {
                            Text("Presets")
                                .font(.custom("Minecraft-Regular", size: 10))
                            
                            Menu {
                                Button {
                                    settings.theme = "Ender Pearl"
                                    settings.backgroudColor = Color("ender_pearl_background")
                                    settings.borderColor = Color("ender_pearl_border")
                                } label: {
                                    Text("Ender Pearl")
                                        .font(.custom("Minecraft-Regular", size: 10))
                                }
                            } label: {
                                Text(settings.theme)
                                    .font(.custom("Minecraft-Regular", size: 10))
                           }
                            .padding(.trailing)
                        }
                    }
                    .tag(ThemeMode.preset)
                    .padding(.bottom, 34)
                    
                    Group {
                        VStack(alignment: .leading) {
                            Text("Custom")
                                .font(.custom("Minecraft-Regular", size: 10))
                            
                            ColorPicker("Background Color", selection: settings.$userBgColor, supportsOpacity: false)
                                .font(.custom("Minecraft-Regular", size: 10))
                                .disabled(settings.themeMode == .preset)
                            
                            ColorPicker("Foreground Color", selection: settings.$userBrColor, supportsOpacity: false)
                                .font(.custom("Minecraft-Regular", size: 10))
                                .disabled(settings.themeMode == .preset)
                        }
                    }
                    .tag(ThemeMode.custom)
                }
                .pickerStyle(.radioGroup)
                .horizontalRadioGroupLayout()
                .onChange(of: settings.themeMode) { newValue in
                    if (newValue == .preset) {
                        settings.backgroudColor = Color("\(settings.theme.lowercased().replacingOccurrences(of: " ", with: "_"))_background")
                        settings.borderColor = Color("\(settings.theme.lowercased().replacingOccurrences(of: " ", with: "_"))_border")
                    } else {
                        settings.backgroudColor = settings.userBgColor
                        settings.borderColor = settings.userBrColor
                    }
                }
                .onChange(of: settings.userBgColor) { newValue in
                    settings.backgroudColor = newValue
                }
                .onChange(of: settings.userBrColor) { newValue in
                    settings.borderColor = newValue
                }
                
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

struct ThemeSettingsView_Previews: PreviewProvider {
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        ThemeSettingsView()
            .frame(width: 450, height: 250)
            .environmentObject(settings)
    }
}
