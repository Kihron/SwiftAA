//
//  Note.swift
//  SwiftAA
//
//  Created by Kihron on 9/22/23.
//

import SwiftUI

struct Note: Identifiable {
    var id = UUID()
    var monument: String
    var stronghold: String
    var outpost: String
    var path: String
    var message: String
}

extension Note {
    static let newNote = Note(monument: "", stronghold: "", outpost: "", path: "", message: "")
}
