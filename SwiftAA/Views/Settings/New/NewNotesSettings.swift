//
//  NewNotesSettings.swift
//  SwiftAA
//
//  Created by Kihron on 9/22/23.
//

import SwiftUI

struct NewNotesSettings: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject private var noteManager = NoteManager.shared
    
    @State private var selected: Note = Note.newNote
    
    var body: some View {
        HStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(noteManager.worldNotes) { note in
                        let idx = noteManager.worldNotes.firstIndex(where: { $0.id == note.id })
                        Button(action: { selected = note }) {
                            Text(getShortName(path: note.path))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical)
                                .background(note == selected ? .blue.opacity(0.2) : .black.opacity(0.001))
                        }
                        .buttonStyle(.plain)
                        
                        if idx ?? 0 < noteManager.worldNotes.count - 1 {
                            Divider()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(width: 175)
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.bouncy, value: noteManager.worldNotes)
            .background(.black.opacity(0.2))
            
            Divider()
            
            VStack(alignment: .leading) {
                if !selected.path.isEmpty {
                    Text("Waypoints")
                        .fontWeight(.bold)
                    
                    SettingsCardView {
                        VStack {
                            WayPointCardView(note: $selected, index: 0, icon: "elder_guardian")
                            WayPointCardView(note: $selected, index: 1, icon: "pillager")
                            WayPointCardView(note: $selected, index: 2, icon: "silverfish")
                        }
                    }
                    .disabled(true)
                    
                    Text("Notes")
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    SettingsCardView {
                        Text(selected.message)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                    
                    Text("Path")
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    SettingsCardView {
                        Text(selected.path)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onAppear {
            if let note = noteManager.worldNotes.first {
                selected = note
            }
        }
        .toolbar {
            if !selected.path.isEmpty {
                ToolbarItem(placement: .destructiveAction) {
                    Button(action: { deleteNote(note: selected) }) {
                        Image(systemName: "trash")
                    }
                    .help("Delete selected note")
                }
            }
        }
    }
    
    private func deleteNote(note: Note) {
        noteManager.deleteNote(note: note, context: context)
        selected = noteManager.worldNotes.first ?? Note.newNote
    }
    
    private func getShortName(path: String) -> String {
        let name = path.lastIndex(of: "/") ?? path.startIndex
        return String(path.suffix(from: name)).replacingOccurrences(of: "/", with: "")
    }
}

#Preview {
    NewNotesSettings()
        .frame(width: 600, height: 500)
}
