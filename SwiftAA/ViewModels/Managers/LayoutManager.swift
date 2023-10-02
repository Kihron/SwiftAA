//
//  LayoutManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/18/23.
//

import SwiftUI

class LayoutManager: ObservableObject {
    @AppStorage("frameStyle") var frameStyle: FrameStyle = .minecraft    
    @AppStorage("modularPanel") var modularPanel: ModularPanel = .leaderboard
    @AppStorage("isNotes") var isNotes: Bool = false
    
    @Published var infoMode: Bool = false
    
    static let shared = LayoutManager()
    
    init() {
        
    }
}
