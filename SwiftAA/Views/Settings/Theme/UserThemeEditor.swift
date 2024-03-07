//
//  UserThemeEditor.swift
//  SwiftAA
//
//  Created by Kihron on 9/21/23.
//

import SwiftUI

struct UserThemeEditor: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var context
    @ObservedObject private var themeManager = ThemeManager.shared
    
    @State private var name: String = ""
    @State private var background: Color = ThemeManager.shared.background
    @State private var border: Color = ThemeManager.shared.border
    @State private var text: Color = ThemeManager.shared.text
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(L10n.Theme.editor)
                    .font(.title2)
                    .fontWeight(.bold)
                
                SettingsCardView {
                    TextField("", text: $name, prompt: Text(L10n.Theme.Editor.name))
                        .focusable(false)
                        .labelsHidden()
                        .lineLimit(1)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .roundedCorners(radius: 5, corners: [.allCorners])
                }
                
                SettingsCardView {
                    HStack {
                        VStack(spacing: 20) {
                            Group {
                                HStack {
                                    ColorPicker("", selection: $background, supportsOpacity: false)
                                    
                                    Text(L10n.Theme.backgroundColor)
                                }
                                
                                HStack {
                                    ColorPicker("", selection: $border, supportsOpacity: false)
                                    
                                    Text(L10n.Theme.borderColor)
                                }
                                
                                HStack {
                                    ColorPicker("", selection: $text, supportsOpacity: false)
                                    
                                    Text(L10n.Theme.textColor)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .labelsHidden()
                        }
                        
                        ThemeSampleView(background: $background, border: $border, text: $text)
                            .frame(width: 200, height: 134)
                            .roundedCorners(radius: 5, corners: [.allCorners])
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack {
                    Button(action: { dismiss() }) {
                        Text(L10n.Button.cancel)
                    }
                    
                    Button(action: { saveTheme() }) {
                        Text(L10n.Button.save)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .frame(width: 500, height: 300)
        .removeFocusOnTap()
    }
    
    private func saveTheme() {
        let name = name.isEmpty ? L10n.Theme.custom : name
        
        themeManager.saveUserTheme(name: name, background: background, border: border, text: text, context: context)
        dismiss()
    }
}

#Preview {
    UserThemeEditor()
        .padding()
}
