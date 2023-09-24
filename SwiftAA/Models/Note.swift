//
//  Note.swift
//  SwiftAA
//
//  Created by Kihron on 9/22/23.
//

import SwiftUI

struct Note: Identifiable, Hashable {
    var id = UUID()
    var monument: String
    var stronghold: String
    var outpost: String
    var path: String
    var message: String
    
    func isEmpty() -> Bool {
        return monument.isEmpty && stronghold.isEmpty && outpost.isEmpty && message.isEmpty
    }
}

extension Note {
    static var newNote: Note {
        let note = Note(monument: "", stronghold: "", outpost: "", path: "", message: "")
        return note
    }
}
