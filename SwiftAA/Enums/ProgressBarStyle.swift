//
//  ProgressBarStyle.swift
//  SwiftAA
//
//  Created by Kihron on 2/11/24.
//

import Foundation

enum ProgressBarStyle: String, CaseIterable, Identifiable, Hashable {
    case enderDragon = "layout.appearance.progress_bar_style.ender_dragon"
    case experience = "layout.appearance.progress_bar_style.experience"

    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
}
