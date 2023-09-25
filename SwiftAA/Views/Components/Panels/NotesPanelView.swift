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
                    .font(.custom("Minecraft-Regular", size: 12))
                
                VStack(spacing: 5) {
                    WayPointCardView(note: $currentNote, index: 0, icon: "elder_guardian")
                    WayPointCardView(note: $currentNote, index: 1, icon: "pillager")
                    WayPointCardView(note: $currentNote, index: 2, icon: "silverfish")
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            VStack(alignment: .leading) {
                Text(L10n.Notes.Panel.View.Bottom.title)
                    .font(.custom("Minecraft-Regular", size: 12))
                
                TextEditor(text: $currentNote.message)
                    .font(.custom("Minecraft-Regular", size: 10))
                    .cornerRadius(5)
                    .padding(.bottom, 15)
                    .disabled(trackerManager.worldPath.isEmpty)
            }
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

struct WayPointCardView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject private var themeManager = UIThemeManager.shared
    @ObservedObject private var trackerManager = TrackerManager.shared
    @ObservedObject private var noteManager = NoteManager.shared
    
    @Binding var note: Note
    
    @State var index: Int
    @State var icon: String
    
    @State private var x: String = ""
    @State private var z: String = ""
    
    var body: some View {
        HStack {
            Image(icon)
                .interpolation(.none)
                .resizable()
                .frame(width: 32, height: 32)
            
            VStack(spacing: 5) {
                HStack {
                    TextField("", text: $x, prompt: Text("X"))
                        .font(.custom("Minecraft-Regular", size: 10))
                        .disabled(trackerManager.worldPath.isEmpty)
                        .background(Color("frame_modern_background"))
                        .roundedCorners(radius: 2, corners: [.allCorners])
                    
                    TextField("", text: $z, prompt: Text("Z"))
                        .font(.custom("Minecraft-Regular", size: 10))
                        .disabled(trackerManager.worldPath.isEmpty)
                        .background(Color("frame_modern_background"))
                        .roundedCorners(radius: 2, corners: [.allCorners])
                }
                
                HStack {
                    ZStack {
                        Text(x.toNether)
                            .font(.custom("Minecraft-Regular", size: 10))
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 4)
                            .background(.red.opacity(0.5))
                            .roundedCorners(radius: 2, corners: [.allCorners])
                    }
                    
                    ZStack {
                        Text(z.toNether)
                            .font(.custom("Minecraft-Regular", size: 10))
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 4)
                            .background(.red.opacity(0.5))
                            .roundedCorners(radius: 2, corners: [.allCorners])
                    }
                }
                .applyThemeText()
            }
        }
        .onAppear {
            withAnimation {
                loadWaypoint()
            }
        }
        .onChange(of: note.path) { _ in
            withAnimation {
                loadWaypoint()
            }
        }
        .onChange(of: x) { _ in
            saveWaypoint()
            noteManager.updateNote(note: note, context: context)
        }
        .onChange(of: z) { _ in
            saveWaypoint()
            noteManager.updateNote(note: note, context: context)
        }
    }
    
    private func saveWaypoint() {
        let value = x + String(repeating: " ", count: max(x.count, z.count) - min(x.count, z.count)) + z
        
        switch index {
            case 0:
                note.monument = value
            case 1:
                note.outpost = value
            default:
                note.stronghold = value
        }
    }
    
    private func loadWaypoint() {
        let value: String
        switch index {
            case 0:
                value = note.monument
            case 1:
                value = note.outpost
            default:
                value = note.stronghold
        }
        
        let mid = value.count / 2
        x = value.dropLast(mid).trimmingCharacters(in: .whitespaces)
        z = value.dropFirst(mid).trimmingCharacters(in: .whitespaces)
    }
}

private extension String {
    var toNether: String {
        get {
            if let num = Int(self) {
                return String((num / 8) - (num < 0 ? 1 : 0))
            } else {
                return "?"
            }
        }
        set {}
    }
}

struct NotesPanelView_Previews: PreviewProvider {
    static var previews: some View {
        NotesPanelView()
            .frame(width: 300, height: 800)
    }
}
