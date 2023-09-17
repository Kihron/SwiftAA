//
//  HAlignment.swift
//  SwiftAA
//
//  Created by Kihron on 9/8/23.
//

import SwiftUI

enum HAlignment: String, CaseIterable, Identifiable, Hashable {
    case leading = "settings.alignment.leading"
    case center = "settings.alignment.center"
    case trailing = "settings.alignment.trailing"
    
    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
}
