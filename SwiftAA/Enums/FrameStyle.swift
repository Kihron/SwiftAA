//
//  FrameStyle.swift
//  SwiftAA
//
//  Created by Kihron on 9/18/23.
//

import SwiftUI

enum FrameStyle: String, SettingsOption {
    case minecraft = "layout.appearance.frame_style.minecraft"
    case geode = "layout.appearance.frame_style.geode"
    case modern = "layout.appearance.frame_style.modern"
    
    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
}
