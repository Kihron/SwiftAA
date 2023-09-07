//
//  ThemeSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 7/21/22.
//

import SwiftUI

struct ThemeSettingsView: View {
    @ObservedObject var themeManager: UIThemeManager = UIThemeManager.shared
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Picker(selection: $themeManager.themeMode, label: Text("")) {
                    Group {
                        VStack(alignment: .leading) {
                            Text(L10n.Theme.presets)
                                .font(.custom("Minecraft-Regular", size: 10))
                            
                            Menu {
                                ForEach(ThemePreset.allCases) { preset in
                                    Button(action: { UIThemeManager.shared.changePreset(preset: preset)}) {
                                        Text(preset.localized)
                                    }
                                }
                            } label: {
                                Text(themeManager.currentPreset.localized)
                                    .font(.custom("Minecraft-Regular", size: 10))
                            }
                            .padding(.trailing)
                            
                            Button(action: {  }) {
                                Text(L10n.Theme.copy)
                                    .font(.custom("Minecraft-Regular", size: 10))
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .disabled(themeManager.themeMode == ThemeMode.custom)
                    }
                    .tag(ThemeMode.preset)
                    .padding(.bottom, 34)
                    
                    Group {
                        VStack(alignment: .leading) {
                            Text(L10n.Theme.custom)
                                .font(.custom("Minecraft-Regular", size: 10))
                            
                            VStack(alignment: .trailing) {
//                                ColorPicker(L10n.Theme.Background.color, selection: $themeManager.userTheme.backgroundColor, supportsOpacity: false)
//                                    .font(.custom("Minecraft-Regular", size: 10))
//                                    .disabled(themeManager.themeMode == .preset)
//                                
//                                ColorPicker(L10n.Theme.Foreground.color, selection: $themeManager.userTheme.borderColor, supportsOpacity: false)
//                                    .font(.custom("Minecraft-Regular", size: 10))
//                                    .disabled(themeManager.themeMode == .preset)
//                                
//                                ColorPicker(L10n.Theme.Text.color, selection: $themeManager.userTheme.textColor, supportsOpacity: false)
//                                    .font(.custom("Minecraft-Regular", size: 10))
//                                    .disabled(themeManager.themeMode == .preset)
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .tag(ThemeMode.custom)
                }
                .pickerStyle(.radioGroup)
                .horizontalRadioGroupLayout()
            }
        }
        .padding()
    }
}

struct ThemeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSettingsView()
            .frame(width: 450, height: 250)
    }
}
