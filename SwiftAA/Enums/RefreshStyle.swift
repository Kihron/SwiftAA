//
//  RefreshStyle.swift
//  SwiftAA
//
//  Created by Kihron on 2/25/24.
//

import SwiftUI


enum RefreshStyle: String, SettingsOption {
    case orb = "layout.appearance.refresh_style.orb"
    case compass = "layout.appearance.refresh_style.compass"
    case clock = "layout.appearance.refresh_style.clock"
    
    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
    
    var icon: String {
        switch self {
            case .orb:
                "xp_orb"
            case .compass:
                "compass"
            case .clock:
                "clock"
        }
    }
}
