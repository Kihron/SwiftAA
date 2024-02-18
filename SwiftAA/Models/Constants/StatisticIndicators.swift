//
//  StatisticIndicators.swift
//  SwiftAA
//
//  Created by Kihron on 2/17/24.
//

import SwiftUI

class EnderPearls: StatisticIndicator {
    var id: String = "minecraft:ender_pearl"
    var key: String = L10n.Statistic.enderPearl(0)
    var name: String = "0 Pearls"
    var icon: String = "ender_pearl"
    var completed: Bool = false
    
    static let shared = EnderPearls()
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let pickedUp = stats["minecraft:picked_up"]?[id] ?? 0
        let used = stats["minecraft:used"]?[id] ?? 0
        let dropped = stats["minecraft:dropped"]?[id] ?? 0
        let crafted = stats["minecraft:crafted"]?["minecraft:ender_eye"] ?? 0
        
        let estimate = max(0, pickedUp - used - dropped - crafted)
        completed = estimate > 0
        key = L10n.Statistic.enderPearl(estimate)
    }
}

class NetherWart: StatisticIndicator {
    var id: String = "minecraft:nether_wart"
    var key: String = L10n.Statistic.netherWart(0)
    var name: String = "0 Wart"
    var icon: String = "nether_wart"
    var completed: Bool = false
    
    static let shared = NetherWart()
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = stats["minecraft:picked_up"]?[id] ?? 0
        completed = count >= 3
        key = L10n.Statistic.netherWart(count)
    }
}

class GhastTears: StatisticIndicator {
    var id: String = "minecraft:ghast_tear"
    var key: String = L10n.Statistic.ghastTears(0)
    var name: String = "0 / 4 Tears"
    var icon: String = "ghast_tear"
    var completed: Bool = false
    
    static let shared = GhastTears()
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = stats["minecraft:picked_up"]?[id] ?? 0
        completed = count >= 4
        key = L10n.Statistic.ghastTears(count)
    }
}

class Pufferfish: StatisticIndicator {
    var id: String = "minecraft:pufferfish"
    var key: String = L10n.Statistic.pufferfish(0)
    var name: String = "0 / 2 Puffers"
    var icon: String = "pufferfish"
    var completed: Bool = false
    
    static let shared = Pufferfish()
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = stats["minecraft:picked_up"]?[id] ?? 0
        completed = count >= 2
        key = L10n.Statistic.pufferfish(count)
    }
}

class AzureBluet: StatisticIndicator {
    var id: String = "minecraft:azure_bluet"
    var key: String = L10n.Statistic.azureBluet
    var name: String = "Azure Bluet"
    var icon: String = "azure_bluet"
    var completed: Bool = false
    
    static let shared = AzureBluet()
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = stats["minecraft:picked_up"]?[id] ?? 0
        completed = count > 0
        key = L10n.Statistic.azureBluet
    }
}

class FermentedEye: StatisticIndicator {
    var id: String = "minecraft:fermented_spider_eye"
    var key: String = L10n.Statistic.fermentedEye
    var name: String = "Fermented Eye"
    var icon: String = "fermented_spider_eye"
    var completed: Bool = false
    
    static let shared = FermentedEye()
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = stats["minecraft:crafted"]?[id] ?? 0
        completed = count > 0
        key = L10n.Statistic.fermentedEye
    }
}
