//
//  NoteManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/6/23.
//

import SwiftUI

class NoteManager: ObservableObject {
    @AppStorage("notes") var notes: [String:[String]] = [:]
    @Published var worldNotes: [Note] = []
    
    static let shared = NoteManager()
    
    init() {
        
    }
    
    var currentWorldNote: Note? {
        return worldNotes.filter({ $0.path == TrackerManager.shared.worldPath }).first
    }
    
    func getWorldNotesFromFetch(fetch: FetchedResults<WorldNote>) {
        worldNotes.removeAll()
        for note in fetch {
            if let id = note.id, let monument = note.monument, let stronghold = note.stronghold, let outpost = note.outpost, let path = note.path, let message = note.message {
                worldNotes.append(Note(id: id, monument: monument, stronghold: stronghold, outpost: outpost, path: path, message: message))
            }
        }
    }
    
    func saveNote(note: Note, context: NSManagedObjectContext) {
        let worldNote = WorldNote(context: context)
        worldNote.id = note.id
        worldNote.monument = note.monument
        worldNote.stronghold = note.stronghold
        worldNote.outpost = note.outpost
        worldNote.path = note.path
        worldNote.message = note.message
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
