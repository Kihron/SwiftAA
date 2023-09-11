//
//  NotesSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 7/26/22.
//

import SwiftUI

struct NotesSettingsView: View {
    @ObservedObject private var noteManager = NoteManager.shared
    @State var selected: [String]? = nil
    @State var selectedWorld: String = ""
    
    var body: some View {
        if (!noteManager.notes.isEmpty) {
            HStack {
                VStack {
                    ScrollView {
                        VStack(alignment: .center, spacing: 5) {
                            ForEach(Array(noteManager.notes).sorted(by: { $0.key.lowercased() < $1.key.lowercased()}), id: \.self.key) { item in
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
                            noteManager.notes.removeValue(forKey: selectedWorld)
                            selected = nil
                            selectedWorld = ""
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                        Button {
                            noteManager.notes.removeAll()
                            selected = nil
                            selectedWorld = ""
                        } label: {
                            Text(L10n.Notes.Clear.all)
                                .font(.custom("Minecraft-Regular", size: 12))
                        }
                    }
                    .padding(.bottom)
                }
                
                TextEditor(text: .constant((selected ?? [L10n.Notes.Select.world]).joined(separator: "\n")))
                    .font(.custom("Minecraft-Regular", size: 10))
                    .disabled(true)
                    .cornerRadius(5)
                    .padding([.top, .bottom, .trailing])
                
                Spacer()
            }
        } else {
            Text(L10n.Notes.none)
                .font(.custom("Minecraft-Regular", size: 24))
        }
    }
}

struct NotesSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NotesSettingsView()
            .frame(width: 500, height: 300)
    }
}
