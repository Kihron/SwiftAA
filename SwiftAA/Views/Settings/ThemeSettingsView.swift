//
//  ThemeSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/6/23.
//

import SwiftUI

struct ThemeSettingsView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject private var themeManager = UIThemeManager.shared
    
    private let columns = Array(repeating: GridItem(.adaptive(minimum: 100), spacing: 20), count: 4)
    
    var body: some View {
        VStack(spacing: 0) {
            ThemeExampleView()
            
            Divider()
            
            SettingsCardView {
                Text(themeManager.label)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
            
            Divider()
            
            VStack {
                ScrollView {
                    SettingsLabel(title: "Custom")
                        .padding(.top, 10)
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        Button(action: { themeManager.saveUserTheme(name: "Test", background: ThemePreset.allCases.randomElement()!.backgroundColor, border: ThemePreset.allCases.randomElement()!.borderColor, text: ThemePreset.allCases.randomElement()!.textColor, context: context) }) {
                            CustomThemeView()
                        }
                        .buttonStyle(.plain)
                        
                        ForEach(themeManager.userThemes) { theme in
                            Button(action: { themeManager.selectUserTheme(theme: theme) }) {
                                ThemePreviewView(theme: theme)
                                    .frame(height: 67)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    SettingsLabel(title: "Presets")
                        .padding(.top, 10)
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(ThemePreset.allCases, id: \.self) { preset in
                            Button(action: { themeManager.changePreset(preset: preset) }) {
                                ThemePreviewView(theme: preset)
                                    .frame(height: 67)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .toolbar {
            if themeManager.themeMode == .custom {
                ToolbarItem(placement: .destructiveAction) {
                    Button(action: { themeManager.deleteUserTheme(context: context) }) {
                        Image(systemName: "trash")
                    }
                }
            }
        }
    }
}

#Preview {
    ThemeSettingsView()
        .frame(width: 500, height: 600)
}
