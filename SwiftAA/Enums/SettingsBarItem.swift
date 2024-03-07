//
//  SettingsBarItem.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI

enum SettingsBarItem: String, CaseIterable, Identifiable, Hashable {
    case tracking = "settings.tracking"
    case layout = "settings.layout"
    case theme = "settings.theme"
    case overlay = "settings.overlay"
    case notes = "settings.notes"
    case updates = "settings.updater"
    case credits = "settings.credits"
    
    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
    
    var icon: String {
        switch self {
            case .tracking:
                "location.fill"
            case .layout:
                "hammer.fill"
            case .theme:
                "paintbrush.fill"
            case .overlay:
                "tv"
            case .notes:
                "note.text"
            case .updates:
                "gear.badge"
            case .credits:
                "hands.and.sparkles.fill"
        }
    }
    
    var color: Color {
        switch self {
            case .tracking:
                .red
            case .layout:
                .blue
            case .theme:
                .indigo
            case .overlay:
                .purple
            case .notes:
                .orange
            case .updates:
                .gray
            case .credits:
                .brown
        }
    }
}
