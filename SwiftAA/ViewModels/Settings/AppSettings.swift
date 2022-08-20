//
//  Settings.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/21/22.
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
    
    //Theme
    @AppStorage("theme") var theme: String = "theme-presets-ender-pearl"
    @AppStorage("themeMode") var themeMode: ThemeMode = .preset
    
    @AppStorage("backgroundColor") var backgroudColor: Color = Color("ender_pearl_background")
    @AppStorage("borderColor") var borderColor: Color = Color("ender_pearl_border")
    @AppStorage("textColor") var textColor: Color = Color("ender_pearl_text")
    
    @AppStorage("userBgColor") var userBgColor: Color = Color("ender_pearl_background")
    @AppStorage("userBrColor") var userBrColor: Color = Color("ender_pearl_border")
    @AppStorage("userTxColor") var userTxColor: Color = Color("ender_pearl_text")
    
    //Overlay
    @AppStorage("showStats") var showStats: Bool = true
    @AppStorage("statsRowPos") var statsRowPos: Bool = true
    
    @AppStorage("userOverlayColor") var userOverlayColor: Color = Color("overlay_green")
    
    //Player
    @AppStorage("player") var player: Player? = nil
    
    //Updater
    @AppStorage("lastUpdateCheck") var lastUpdateCheck: Date? = nil
}

enum TrackingMode: String {
    case seamless, directory
}

enum ThemeMode: String {
    case preset, custom
}
