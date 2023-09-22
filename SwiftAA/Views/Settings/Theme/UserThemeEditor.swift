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
    @ObservedObject private var themeManager = UIThemeManager.shared
    
    @State private var name: String = ""
    @State private var background: Color = UIThemeManager.shared.background
    @State private var border: Color = UIThemeManager.shared.border
    @State private var text: Color = UIThemeManager.shared.text
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Theme Editor")
                    .font(.title2)
                    .fontWeight(.bold)
                
                SettingsCardView {
                    TextField("", text: $name, prompt: Text("Name"))
                        .focusable(false)
                        .labelsHidden()
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .roundedCorners(radius: 5, corners: [.allCorners])
                }
                
                SettingsCardView {
                    HStack {
                        VStack(spacing: 20) {
                            Group {
                                HStack {
                                    ColorPicker("", selection: $background, supportsOpacity: false)
                                    
                                    Text("Background")
                                }
                                
                                HStack {
                                    ColorPicker("", selection: $border, supportsOpacity: false)
                                    
                                    Text("Border")
                                }
                                
                                HStack {
                                    ColorPicker("", selection: $text, supportsOpacity: false)
                                    
                                    Text("Text")
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
                        Text("Cancel")
                    }
                    
                    Button(action: { saveTheme() }) {
                        Text("Save")
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
        let name = name.isEmpty ? "Custom" : name
        
        themeManager.saveUserTheme(name: name, background: background, border: border, text: text, context: context)
        dismiss()
    }
}

#Preview {
    UserThemeEditor()
        .padding()
}
