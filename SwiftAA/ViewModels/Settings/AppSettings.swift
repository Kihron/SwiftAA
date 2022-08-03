//
//  Settings.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/21/22.
//

import SwiftUI

class AppSettings: ObservableObject {
    @AppStorage("gameVersion") var gameVersion: String = "1.16"
    @AppStorage("customSavesPath") var customSavesPath: String = ""
    @AppStorage("trackingMode") var trackingMode: TrackingMode = .seamless
    @AppStorage("notes") var notes: [String:[String]] = [:]
    @Published var worldPath: String = ""
    
    @AppStorage("theme") var theme: String = "Ender Pearl"
    @AppStorage("themeMode") var themeMode: ThemeMode = .preset
    
    @AppStorage("backgroundColor") var backgroudColor: Color = Color("ender_pearl_background")
    @AppStorage("borderColor") var borderColor: Color = Color("ender_pearl_border")
    
    @AppStorage("userBgColor") var userBgColor: Color = Color("ender_pearl_background")
    @AppStorage("userBrColor") var userBrColor: Color = Color("ender_pearl_border")
}

enum TrackingMode: String {
    case seamless, directory
}

enum ThemeMode: String {
    case preset, custom
}
