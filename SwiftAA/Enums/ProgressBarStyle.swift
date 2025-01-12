//
//  ProgressBarStyle.swift
//  SwiftAA
//
//  Created by Kihron on 2/11/24.
//

import Foundation

enum ProgressBarStyle: String, SettingsOption {
    case enderDragon = "layout.appearance.progress_bar_style.ender_dragon"
    case experience = "layout.appearance.progress_bar_style.experience"
    case modern = "layout.appearance.progress_bar_style.modern"

    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
}
