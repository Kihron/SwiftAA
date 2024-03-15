//
//  LayoutManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/18/23.
//

import SwiftUI

class LayoutManager: ObservableObject {
    @AppStorage("modularPanel") var modularPanel: ModularPanel = .leaderboard
    
    @AppStorage("frameStyle") var frameStyle: FrameStyle = .minecraft
    @AppStorage("progressBarStyle") var progressBarStyle: ProgressBarStyle = .enderDragon
    
    @AppStorage("refreshStyle") var refreshStyle: RefreshStyle = .orb
    @AppStorage("refreshSpeed") var refreshSpeed: Double = 1.5
    
    @AppStorage("matchThemeColor") var matchThemeColor: Bool = true
    @AppStorage("isNotes") var isNotes: Bool = false
    
    @Published var infoMode: Bool = false
    
    static let shared = LayoutManager()
    
    init() {
        
    }
}
