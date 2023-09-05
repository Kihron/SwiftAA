//
//  Potions.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 9/5/23.
//

import SwiftUI

enum Potion: String, CaseIterable, Identifiable, Hashable {
    case strength
    case weakness
    case swiftness
    case slowness
    case nightVision
    case invisibility
    case leaping
    case slowFalling
    case waterBreathing
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        switch self {
        case .strength: return "strength"
        case .weakness: return "weakness"
        case .swiftness: return "swiftness"
        case .slowness: return "slowness"
        case .nightVision: return "night_vision"
        case .invisibility: return "invisibility"
        case .leaping: return "leaping"
        case .slowFalling: return "slow_falling"
        case .waterBreathing: return "water_breathing"
        }
    }
    
    var ingredients: [String] {
        switch self {
        case .strength: return ["nether_wart", "blaze_powder"]
        case .weakness: return ["fermented_spider_eye"]
        case .swiftness: return ["nether_wart", "sugar"]
        case .slowness: return ["nether_wart", "sugar", "fermented_spider_eye"]
        case .nightVision: return ["nether_wart", "golden_carrot"]
        case .invisibility: return ["nether_wart", "golden_carrot", "fermented_spider_eye"]
        case .leaping: return ["nether_wart", "rabbit_foot"]
        case .slowFalling: return ["nether_wart", "phantom_membrane"]
        case .waterBreathing: return ["nether_wart", "pufferfish"]
        }
    }
}
