//
//  UIThemeManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/4/23.
//

import SwiftUI

class UIThemeManager: ObservableObject {
    @AppStorage("currentPreset") var currentPreset: ThemePreset = .enderPearl
    @AppStorage("userThemeData") private var userThemeData: Data?
    @AppStorage("themeMode") var themeMode: ThemeMode = .preset
    
    static let shared = UIThemeManager()
    
    var userTheme: UserTheme {
        get {
            if let data = userThemeData,
               let decodedTheme = try? JSONDecoder().decode(UserTheme.self, from: data) {
                return decodedTheme
            } else {
                return .initial
            }
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                userThemeData = encodedData
            }
        }
    }
    
    var background: Color {
        return themeMode == .preset ? currentPreset.backgroundColor : userTheme.backgroundColor
    }
    
    var border: Color {
        return themeMode == .preset ? currentPreset.borderColor : userTheme.borderColor
    }
    
    var text: Color {
        return themeMode == .preset ? currentPreset.textColor : userTheme.textColor
    }
    
    init() {
        
    }
    
    func changePreset(preset: ThemePreset) {
        self.currentPreset = preset
    }
    
    func copyPresetToUserTheme() {
        userTheme.backgroundColor = currentPreset.backgroundColor
        userTheme.borderColor = currentPreset.borderColor
        userTheme.textColor = currentPreset.textColor
        self.themeMode = .custom
    }
}

enum ThemeMode: String {
    case preset, custom
}
