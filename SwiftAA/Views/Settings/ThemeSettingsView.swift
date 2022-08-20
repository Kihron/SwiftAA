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
                            Text("theme-presets", comment: "Title: preset options for color scheme")
                                .font(.custom("Minecraft-Regular", size: 10))
                            
                            Menu {
                                Button {
                                    settings.theme = "theme-presets-ender-pearl"
                                    settings.backgroudColor = Color("ender_pearl_background")
                                    settings.borderColor = Color("ender_pearl_border")
                                    settings.textColor = Color("ender_pearl_text")
                                } label: {
                                    Text("theme-presets-ender-pearl", comment: "Ender Pearl Theme")
                                        .font(.custom("Minecraft-Regular", size: 10))
                                }
                                Button {
                                    settings.theme = "theme-presets-blazed"
                                    settings.backgroudColor = Color("blazed_background")
                                    settings.borderColor = Color("blazed_border")
                                    settings.textColor = Color("blazed_text")
                                } label: {
                                    Text("theme-presets-blazed", comment: "Blazed Theme")
                                        .font(.custom("Minecraft-Regular", size: 10))
                                }
                                Button {
                                    settings.theme = "theme-presets-brick"
                                    settings.backgroudColor = Color("brick_background")
                                    settings.borderColor = Color("brick_border")
                                    settings.textColor = Color("brick_text")
                                } label: {
                                    Text("theme-presets-brick", comment: "Brick Theme")
                                        .font(.custom("Minecraft-Regular", size: 10))
                                }
                                Button {
                                    settings.theme = "theme-presets-berry"
                                    settings.backgroudColor = Color("berry_background")
                                    settings.borderColor = Color("berry_border")
                                    settings.textColor = Color("berry_text")
                                } label: {
                                    Text("theme-presets-berry", comment: "Berry Theme")
                                        .font(.custom("Minecraft-Regular", size: 10))
                                }
                            } label: {
                                Text(settings.theme.localized)
                                    .font(.custom("Minecraft-Regular", size: 10))
                            }
                            .disabled(settings.themeMode == ThemeMode.custom)
                            .padding(.trailing)
                            
                            Spacer()
                        }
                    }
                    .tag(ThemeMode.preset)
                    .padding(.bottom, 34)
                    
                    Group {
                        VStack(alignment: .leading) {
                            Text("theme-custom", comment: "Title: custom user color scheme")
                                .font(.custom("Minecraft-Regular", size: 10))
                            
                            VStack(alignment: .trailing) {
                                ColorPicker("theme-background-color", selection: settings.$userBgColor, supportsOpacity: false)
                                    .font(.custom("Minecraft-Regular", size: 10))
                                    .disabled(settings.themeMode == .preset)
                                
                                ColorPicker("theme-foreground-color", selection: settings.$userBrColor, supportsOpacity: false)
                                    .font(.custom("Minecraft-Regular", size: 10))
                                    .disabled(settings.themeMode == .preset)
                                
                                ColorPicker("theme-text-color", selection: settings.$userTxColor, supportsOpacity: false)
                                    .font(.custom("Minecraft-Regular", size: 10))
                                    .disabled(settings.themeMode == .preset)
                            }
                            Spacer()
                        }
                    }
                    .tag(ThemeMode.custom)
                }
                .pickerStyle(.radioGroup)
                .horizontalRadioGroupLayout()
                .onChange(of: settings.themeMode) { newValue in
                    if (newValue == .preset) {
                        settings.backgroudColor = Color("\(settings.theme.dropFirst(14).lowercased().replacingOccurrences(of: "-", with: "_"))_background")
                        settings.borderColor = Color("\(settings.theme.dropFirst(14).lowercased().replacingOccurrences(of: "-", with: "_"))_border")
                        settings.textColor = Color("\(settings.theme.dropFirst(14).lowercased().replacingOccurrences(of: "-", with: "_"))_text")
                    } else {
                        settings.backgroudColor = settings.userBgColor
                        settings.borderColor = settings.userBrColor
                        settings.textColor = settings.userTxColor
                    }
                }
                .onChange(of: settings.userBgColor) { newValue in
                    settings.backgroudColor = newValue
                }
                .onChange(of: settings.userBrColor) { newValue in
                    settings.borderColor = newValue
                }
                .onChange(of: settings.userTxColor) { newValue in
                    settings.textColor = newValue
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
