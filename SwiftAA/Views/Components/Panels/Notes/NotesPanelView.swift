//
//  NotesPanelView.swift
//  SwiftAA
//
//  Created by Kihron on 7/23/22.
//

import SwiftUI

struct NotesPanelView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject private var trackerManager = TrackerManager.shared
    @ObservedObject private var noteManager = NoteManager.shared
    
    @State private var currentNote: Note = Note.newNote
    @State private var userInteracted: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(L10n.Notes.Panel.View.Top.title)
                    .minecraftFont(size: 12)
                
                VStack(spacing: 5) {
                    WaypointCardView(note: $currentNote, index: 0, icon: "elder_guardian")
                    WaypointCardView(note: $currentNote, index: 1, icon: "pillager")
                    WaypointCardView(note: $currentNote, index: 2, icon: "silverfish")
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            VStack(alignment: .leading) {
                Text(L10n.Notes.Panel.View.Bottom.title)
                    .minecraftFont(size: 12)
                
                TextEditor(text: $currentNote.message)
                    .minecraftFont()
                    .cornerRadius(5)
                    .padding(.bottom, 15)
                    .disabled(trackerManager.worldPath.isEmpty)
            }
            // find . -type f -name "*.swift" -exec sed -i '' -e 's/\.font(\.custom("Minecraft-Regular", size: 10))/.minecraftFont()/g' -e 's/\.font(\.custom("Minecraft-Regular", size: \([0-9]*\)))/.minecraftFont(size: \1)/g' {} +

        }
        .padding()
        .applyThemeModifiers()
        .onAppear {
            withAnimation {
                updateCurrentNote(path: trackerManager.worldPath)
            }
        }
        .onChange(of: trackerManager.worldPath) { path in
            userInteracted = false
            withAnimation {
                updateCurrentNote(path: path)
            }
        }
        .onChange(of: currentNote.message) { _ in
            if userInteracted || (!currentNote.message.isEmpty && !currentNote.path.isEmpty) {
                noteManager.updateNote(note: currentNote, context: context)
                userInteracted = true
            }
        }
    }
    
    private func updateCurrentNote(path: String) {
        if currentNote.isEmpty() {
            noteManager.deleteNote(note: currentNote, context: context)
        }
        
        if !path.isEmpty {
            if let note = noteManager.currentWorldNote {
                currentNote = note
            } else {
                currentNote = Note.newNote
                currentNote.path = path
                noteManager.saveNote(note: currentNote, context: context)
            }
        } else {
            currentNote = Note.newNote
        }
    }
}

struct NotesPanelView_Previews: PreviewProvider {
    static var previews: some View {
        NotesPanelView()
            .frame(width: 300, height: 800)
    }
}
