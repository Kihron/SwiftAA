//
//  Settings.swift
//  SwiftAA
//
//  Created by Kihron on 7/21/22.
//

import SwiftUI

class AppSettings: ObservableObject {
    //Tracking
    @Published var worldPath: String = ""
    
    //Notes
    @AppStorage("notes") var notes: [String:[String]] = [:]
    
    //Overlay
    @AppStorage("showStats") var showStats: Bool = true
    @AppStorage("statsRowPos") var statsRowPos: Bool = true
    @AppStorage("showBar") var showBar: Bool = true
    
    @AppStorage("overlayWidth") var overlayWidth: Double = 400
    @AppStorage("overlayLoaded") var overlayLoaded: Bool = false
    
    //Player
    @AppStorage("player") var player: Player? = nil
    
    //Updater
    @AppStorage("lastUpdateCheck") var lastUpdateCheck: Date? = nil
    @AppStorage("checkAutomatically") var checkAutomatically: Bool = true
}

