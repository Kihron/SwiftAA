//
//  UIThemeManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/4/23.
//

import SwiftUI

class UIThemeManager: ObservableObject {
    @AppStorage("currentPreset") var currentPreset: ThemePreset = .enderPearl
    @AppStorage("themeMode") var themeMode: ThemeMode = .preset
    
    static let shared = UIThemeManager()
    
    var background: Color {
        return currentPreset.backgroundColor
    }
    
    var border: Color {
        return currentPreset.borderColor
    }
    
    var text: Color {
        return currentPreset.textColor
    }
    
    init() {
        
    }
    
    func changePreset(preset: ThemePreset) {
        self.currentPreset = preset
    }
}

enum ThemeMode: String {
    case preset, custom
}
