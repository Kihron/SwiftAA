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
                Text(L10n.Notes.PanelView.waypoints)
                    .minecraftFont(size: 12)
                
                VStack(spacing: 5) {
                    WaypointCardView(note: $currentNote, index: 0, icon: "elder_guardian")
                    WaypointCardView(note: $currentNote, index: 1, icon: "pillager")
                    WaypointCardView(note: $currentNote, index: 2, icon: "silverfish")
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            VStack(alignment: .leading) {
                Text(L10n.Notes.PanelView.notes)
                    .minecraftFont(size: 12)
                
                TextEditor(text: $currentNote.message)
                    .minecraftFont()
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
            // /execute in minecraft:overworld run tp @s -90.50 66.00 174.50 0.00 0.00
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
    
    private let f3CRegex = #//execute in [^/]*(overworld|nether|end) run tp @s (-?\d+\.\d+) (-?\d+\.\d+) (-?\d+\.\d+) -?\d+\.\d+ -?\d+\.\d+/#
    
    private func checkF3C(input: String) -> String {
        if let match = input.firstMatch(of: f3CRegex),
           case let (_, world, xStr, yStr, zStr) = match.output {
            var xD = Double(xStr) ?? 0
            let yD = Double(yStr) ?? 0
            var zD = Double(zStr) ?? 0
            
            if world == "nether" {
                xD *= 8
                zD *= 8
            }
            
            let (x, y, z) = ("\(Int(xD))", "\(Int(yD))", "\(Int(zD))")
            let (nx, nz) = (x.toNether, z.toNether)
            
            let out = world == "end" ? "(e: \(x) \(y) \(z))" : "(o: \(x) \(y) \(z); n: \(nx) \(y) \(nz))"
            return input.replacing(f3CRegex, with: out)
        } else {
            return input
        }
    }
}

struct NotesPanelView_Previews: PreviewProvider {
    static var previews: some View {
        NotesPanelView()
            .frame(width: 300, height: 800)
            .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
    }
}
