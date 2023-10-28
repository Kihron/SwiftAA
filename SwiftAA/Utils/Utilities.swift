//
//  Utilities.swift
//  SwiftAA
//
//  Created by Kihron on 10/28/23.
//

import SwiftUI

class Utilities {
    static private let indicators = DataManager.shared.stats
    
    static func getSpecificStats(types: [StatusType]) -> [Indicator] {
        if let array = indicators as? [StatusIndicator] {
            return array.filter { indicator in
                for type in types {
                    if indicator.type == type {
                        return true
                    }
                }
                return false
            }
        }
        return indicators
    }
}
