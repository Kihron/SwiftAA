//
//  ModularPanel.swift
//  SwiftAA
//
//  Created by Kihron on 9/18/23.
//

import SwiftUI

enum ModularPanel: String, SettingsOption {
    case leaderboard = "modular.leaderboard"
    case potionPanel = "modular.potion_panel"
    
    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
}

