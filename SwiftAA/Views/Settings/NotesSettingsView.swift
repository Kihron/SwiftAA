//
//  NotesSettingsView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/26/22.
//

import SwiftUI

struct NotesSettingsView: View {
    @EnvironmentObject var settings: AppSettings
    @State var selected: [String]? = nil
    @State var selectedWorld: String = ""
    
    var body: some View {
        if (!settings.notes.isEmpty) {
            HStack {
                VStack {
                    ScrollView {
                        VStack(alignment: .center, spacing: 5) {
                            ForEach(Array(settings.notes).sorted(by: { $0.key.lowercased() < $1.key.lowercased()}), id: \.self.key) { item in
                                Button {
                                    selected = item.value
                                    selectedWorld = item.key
                                } label: {
                                    Text(item.key.suffix(from: (item.key.lastIndex(of: "/") ?? item.key.firstIndex(of: "/"))!).dropFirst())
                                        .font(.custom("Minecraft-Regular", size: 12))
                                        .frame(width: 100)
                                }
                                .background((selectedWorld == item.key) ? .blue : .clear)
                                .cornerRadius(5)
                            }
                        }
                    }
                    .padding()
                    
                    HStack {
                        Button {
                            settings.notes.removeValue(forKey: selectedWorld)
                            selected = nil
                            selectedWorld = ""
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                        Button {
                            settings.notes.removeAll()
                            selected = nil
                            selectedWorld = ""
                        } label: {
                            Text("notes-clear-all", comment: "Button: delete all notes")
                                .font(.custom("Minecraft-Regular", size: 12))
                        }
                    }
                    .padding(.bottom)
                }
                
                TextEditor(text: .constant((selected ?? ["notes-select-world".localized]).joined(separator: "\n")))
                    .font(.custom("Minecraft-Regular", size: 10))
                    .disabled(true)
                    .cornerRadius(5)
                    .padding([.top, .bottom, .trailing])
                
                Spacer()
            }
        } else {
            Text("notes-none", comment: "Title: no notes available/recorded")
                .font(.custom("Minecraft-Regular", size: 24))
        }
    }
}

struct NotesSettingsView_Previews: PreviewProvider {
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        NotesSettingsView()
            .frame(width: 500, height: 300)
            .environmentObject(settings)
    }
}
