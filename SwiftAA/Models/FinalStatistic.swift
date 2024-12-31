//
//  Stats.swift
//  SwiftAA
//
//  Created by Kihron on 8/18/22.
//

import SwiftUI

struct FinalStatistic: Identifiable {
    var id: String
    var type: String
    var factor: Int = 1
    var icon: String
    var secondaryIcon: String
    var tooltip: String = ""
    var flipped: Bool = false
    
    @MainActor func getValue(progress: ProgressManager) -> String {
        let value = Double(progress.getSpecialStatistic(type: type, id: id))
        if factor > 1 {
            return String(format: factor >= 10 ? "%.1f" : "%.0f", value / Double(factor))
        } else {
            return value >= 1000 ? String(format: "%.1fk", value / 1000) : "\(Int(value))"
        }
    }
}

