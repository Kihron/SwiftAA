//
//  FrameStyle.swift
//  SwiftAA
//
//  Created by Kihron on 9/18/23.
//

import SwiftUI

enum FrameStyle: String, CaseIterable, Identifiable, Hashable {
    case minecraft = "Minecraft"
    case geode = "Geode"
    case modern = "Modern"
    
    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
}
