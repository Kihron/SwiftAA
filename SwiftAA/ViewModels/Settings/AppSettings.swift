//
//  Settings.swift
//  SwiftAA
//
//  Created by Kihron on 7/21/22.
//

import SwiftUI

class AppSettings: ObservableObject {
    //Tracking
    @AppStorage("gameVersion") var gameVersion: String = "1.16"
    @AppStorage("customSavesPath") var customSavesPath: String = ""
    @AppStorage("trackingMode") var trackingMode: TrackingMode = .seamless
    @Published var worldPath: String = ""
    
    //Notes
    @AppStorage("notes") var notes: [String:[String]] = [:]
    
    @AppStorage("userBgColor") var userBgColor: Color = Color("ender_pearl_background")
    @AppStorage("userBrColor") var userBrColor: Color = Color("ender_pearl_border")
    @AppStorage("userTxColor") var userTxColor: Color = Color("ender_pearl_text")
    
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

enum TrackingMode: String {
    case seamless, directory
}

