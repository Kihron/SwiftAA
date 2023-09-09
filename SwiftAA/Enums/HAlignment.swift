//
//  HAlignment.swift
//  SwiftAA
//
//  Created by Kihron on 9/8/23.
//

import SwiftUI

enum HAlignment: String, CaseIterable, Identifiable, Hashable {
    case leading = "leading"
    case center = "center"
    case trailing = "trailing"
    
    var id: UUID {
        return UUID()
    }
    
    var label: String {
        return rawValue
    }
}
