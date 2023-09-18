//
//  LayoutManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/18/23.
//

import SwiftUI

class LayoutManager: ObservableObject {
    @AppStorage("modularPanel") var modularPanel: ModularPanel = .leaderboard
    @AppStorage("isNotes") var isNotes: Bool = false
    
    static let shared = LayoutManager()
    
    init() {
        
    }
}
