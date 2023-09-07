//
//  NoteManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/6/23.
//

import SwiftUI

class NoteManager: ObservableObject {
    @AppStorage("notes") var notes: [String:[String]] = [:]
    
    static let shared = NoteManager()
    
    init() {
        
    }
}
