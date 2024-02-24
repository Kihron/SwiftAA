//
//  LayoutStyle.swift
//  SwiftAA
//
//  Created by Kihron on 9/27/23.
//

import SwiftUI

enum LayoutStyle: String, SettingsOption {
    case standard = "tracking.view_style.standard"
    case vertical = "tracking.view_style.vertical"
    case minimalist = "tracking.view_style.minimalistic"
    
    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
    
    static func getAvailableStyles(version: Version) -> [LayoutStyle] {
        switch version {
            case .v1_16:
                return LayoutStyle.allCases
            case .v1_19:
                return [.standard]
            case .v1_20:
                return [.standard, .minimalist]
        }
    }
}
