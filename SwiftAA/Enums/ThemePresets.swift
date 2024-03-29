//
//  ThemePresets.swift
//  SwiftAA
//
//  Created by Kihron on 9/4/23.
//

import SwiftUI

enum ThemePreset: String, CaseIterable, Identifiable, Hashable, Theme {
    case enderPearl = "ender_pearl"
    case githubDark = "github_dark"
    case highContrast = "high_contrast"
    case blazed = "blazed"
    case brick = "brick"
    case berry = "berry"
    case dark = "dark"
    case light = "light"
    
    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
    
    var localized: String {
        return "theme.presets.\(label)".localized
    }
    
    private var colorPath: String {
        return label.replacingOccurrences(of: ".", with: "_")
    }
    
    var backgroundColor: Color {
        return Color("\(colorPath)_background")
    }
    
    var borderColor: Color {
        return Color("\(colorPath)_border")
    }
    
    var textColor: Color {
        return Color("\(colorPath)_text")
    }
}
