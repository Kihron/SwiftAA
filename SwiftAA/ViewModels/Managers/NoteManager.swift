//
//  NoteManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/6/23.
//

import SwiftUI

class NoteManager: ObservableObject {
    @Published var worldNotes: [Note] = []
    
    private var trackerManager = TrackerManager.shared
    
    static let shared = NoteManager()
    
    init() {
        
    }
    
    var currentWorldNote: Note? {
        return worldNotes.filter({ $0.path == trackerManager.worldPath }).first
    }
    
    func getWorldNotesFromFetch(fetch: FetchedResults<WorldNote>, context: NSManagedObjectContext) {
        worldNotes.removeAll()
        for worldNote in fetch {
            if let id = worldNote.id, let monument = worldNote.monument, let stronghold = worldNote.stronghold, let outpost = worldNote.outpost, let path = worldNote.path, let message = worldNote.message {
                let note = Note(id: id, monument: monument, stronghold: stronghold, outpost: outpost, path: path, message: message)
                
                if note.isEmpty() {
                    deleteNote(note: note, context: context)
                } else {
                    worldNotes.append(note)
                }
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
            
            withAnimation {
                worldNotes.append(note)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateNote(note: Note, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<WorldNote> = WorldNote.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", note.id as CVarArg)
        
        do {
            let objects = try context.fetch(fetchRequest)
            if let object = objects.first {
                object.monument = note.monument
                object.stronghold = note.stronghold
                object.outpost = note.outpost
                object.path = note.path
                object.message = note.message
                
                try context.save()
                
                if let idx = worldNotes.firstIndex(where: { $0.id == note.id }) {
                    worldNotes[idx].monument = note.monument
                    worldNotes[idx].stronghold = note.stronghold
                    worldNotes[idx].outpost = note.outpost
                    worldNotes[idx].path = note.path
                    worldNotes[idx].message = note.message
                }
            } else {
                print("Object not found")
            }
        } catch {
            print("Failed to update object")
        }
    }
    
    func deleteNote(note: Note, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<WorldNote> = WorldNote.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", note.id as CVarArg)
        
        do {
            let objects = try context.fetch(fetchRequest)
            guard !objects.isEmpty, let object = objects.first else {
                return
            }
            
            context.delete(object)
            try context.save()
            
            withAnimation {
                worldNotes.removeAll(where: { $0.id == note.id })
            }
        } catch {
            print("Failed to delete object")
        }
    }
    
    func deleteAllNotes(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<WorldNote> = WorldNote.fetchRequest()
        
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects {
                context.delete(object)
                try context.save()
            }
            
            withAnimation {
                worldNotes.removeAll()
            }
        } catch {
            print("Failed to delete all notes")
        }
    }
}
