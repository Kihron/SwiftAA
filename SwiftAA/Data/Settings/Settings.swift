//
//  Settings.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/21/22.
//

import SwiftUI

class AppSettings: ObservableObject {
    @Published var gameVersion: String = "1.16"
    @Published var customSavesPath: String = ""
    
    func save() {
        UserDefaults.standard.set(gameVersion, forKey: "gameVersion")
        UserDefaults.standard.set(customSavesPath, forKey: "customSavesFolder")
    }
    
    func load() {
        gameVersion = UserDefaults.standard.string(forKey: "gameVersion") ?? "1.16"
        customSavesPath = UserDefaults.standard.string(forKey: "customSavesFolder") ?? ""
    }
}
