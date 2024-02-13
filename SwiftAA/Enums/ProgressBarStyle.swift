//
//  ProgressBarStyle.swift
//  SwiftAA
//
//  Created by Kihron on 2/11/24.
//

import Foundation

enum ProgressBarStyle: String, CaseIterable, Identifiable, Hashable {
    case enderDragon = "Ender Dragon"
    case experience = "Experience"

    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
}
