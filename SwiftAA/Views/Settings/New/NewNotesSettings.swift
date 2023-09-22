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
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    NewNotesSettings()
}
