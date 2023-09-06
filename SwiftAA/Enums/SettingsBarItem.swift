//
//  SettingsBarItem.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 9/5/23.
//

import SwiftUI

enum SettingsBarItem: String, CaseIterable, Identifiable, Hashable {
    case tracking = "settings.tracking"
    case theme = "settings.theme"
    case overlay = "settings.overlay"
    case notes = "settings.notes"
    case updates = "settings.updater"
    
    var id: UUID {
        return UUID()
    }
    
    var label: String {
        return rawValue
    }
    
    var icon: String {
        switch self {
            case .tracking:
                "compass.drawing"
            case .theme:
                "paintpalette"
            case .overlay:
                "ipad.landscape"
            case .notes:
                "note.text"
            case .updates:
                "gear.badge"
        }
    }
    
    var color: Color {
        switch self {
            case .tracking:
                .red
            case .theme:
                .cyan
            case .overlay:
                .purple
            case .notes:
                .yellow
            case .updates:
                .gray
        }
    }
}

