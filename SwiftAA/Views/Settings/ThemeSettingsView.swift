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
                                self.createPresetButton(name: "ender-pearl")
                                self.createPresetButton(name: "github-dark")
                                self.createPresetButton(name: "high-contrast")
                                self.createPresetButton(name: "blazed")
                                self.createPresetButton(name: "brick")
                                self.createPresetButton(name: "berry")
                                self.createPresetButton(name: "dark")
                                self.createPresetButton(name: "light")
                            } label: {
                                Text(settings.theme.localized)
                                    .font(.custom("Minecraft-Regular", size: 10))
                            }
                            .padding(.trailing)
                            
                            Button {
                                settings.userBgColor = settings.backgroudColor
                                settings.userBrColor = settings.borderColor
                                settings.userTxColor = settings.textColor
                                settings.themeMode = ThemeMode.custom
                            } label: {
                                Text("Copy to Custom")
                                    .font(.custom("Minecraft-Regular", size: 10))
                            }
                            
                            Spacer()
                        }
                        .disabled(settings.themeMode == ThemeMode.custom)
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
    
    func createPresetButton(name: String) -> Button<Text> {
        let colorName = name.replacingOccurrences(of: "-", with: "_")
        let view = Button {
            settings.theme = "theme-presets-\(name)"
            settings.backgroudColor = Color("\(colorName)_background")
            settings.borderColor = Color("\(colorName)_border")
            settings.textColor = Color("\(colorName)_text")
        } label: {
            Text("theme-presets-\(name)".localized)
                .font(.custom("Minecraft-Regular", size: 10))
        }
        return view
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
