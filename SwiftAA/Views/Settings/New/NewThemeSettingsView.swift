//
//  NewThemeSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/6/23.
//

import SwiftUI

struct NewThemeSettingsView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject private var themeManager = UIThemeManager.shared
    
    @FetchRequest(entity: UserThemes.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserThemes.name, ascending: true)])
    private var fetch: FetchedResults<UserThemes>
    
    private let columns = Array(repeating: GridItem(.adaptive(minimum: 100), spacing: 20), count: 4)
    
    var body: some View {
        VStack(spacing: 0) {
            ThemeExampleView()
            
            Divider()
            
            SettingsCardView {
                Text(themeManager.currentPreset.localized)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
            
            Divider()
            
            VStack {
                ScrollView {
                    SettingsLabel(title: "Custom")
                        .padding(.top, 10)
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        Button(action: { themeManager.saveUserTheme(name: "Test", background: ThemePreset.enderPearl.backgroundColor, border: ThemePreset.enderPearl.borderColor, text: ThemePreset.enderPearl.textColor, context: context) }) {
                            CustomThemeView()
                        }
                        .buttonStyle(.plain)
                        
                        ForEach(themeManager.userThemes) { theme in
                            Button(action: { themeManager.deleteUserTheme(theme: theme, context: context) }) {
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
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .onAppear {
            themeManager.getUserThemesFromFetch(fetch: fetch)
        }
    }
}

#Preview {
    NewThemeSettingsView()
        .frame(width: 500, height: 600)
}
