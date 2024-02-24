//
//  NotesSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/22/23.
//

import SwiftUI

struct NotesSettingsView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject private var noteManager = NoteManager.shared
    
    @State private var selected: Note = Note.newNote
    
    private var folderExists: Bool {
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: selected.path)
    }
    
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
            
            ScrollView {
                VStack(alignment: .leading) {
                    if !selected.path.isEmpty {
                        Text(L10n.Notes.PanelView.waypoints)
                            .fontWeight(.bold)
                        
                        SettingsCardView {
                            VStack {
                                WaypointCardView(note: $selected, index: 0, icon: "elder_guardian")
                                WaypointCardView(note: $selected, index: 1, icon: "pillager")
                                WaypointCardView(note: $selected, index: 2, icon: "silverfish")
                            }
                            .contentTransition(.numericText())
                        }
                        .disabled(true)
                        
                        Text(L10n.Notes.PanelView.notes)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        SettingsCardView {
                            Text(selected.message)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        }
                        
                        Text(L10n.Notes.path)
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
        }
        .animation(.bouncy, value: selected)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onAppear {
            if let note = noteManager.worldNotes.first {
                selected = note
            }
        }
        .toolbar {
            if !selected.path.isEmpty {
                ToolbarItem(placement: .automatic) {
                    VStack {
                        if folderExists {
                            Button(action: { showInFinder() }) {
                                Image(systemName: "folder")
                            }
                            .help(L10n.Notes.Button.showInFolder)
                        }
                    }
                    .frame(width: 32, height: 32)
                    .animation(.linear(duration: 0.2), value: folderExists)
                }
                
                ToolbarItem(placement: .automatic) {
                    Button(action: { deleteNote(note: selected) }) {
                        Image(systemName: "trash")
                    }
                    .help(L10n.Notes.Button.deleteSelectedNote)
                }
            }
        }
    }
    
    private func showInFinder() {
        let url = URL(filePath: selected.path)
        NSWorkspace.shared.activateFileViewerSelecting([url])
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
    NotesSettingsView()
        .frame(width: 600, height: 500)
}
