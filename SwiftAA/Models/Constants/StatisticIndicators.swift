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
    
    private let enderEye = "minecraft:ender_eye"
    
    func update(progress: ProgressManager) {
        let estimate = max(0, progress.timesPickedUp(id) - progress.timesUsed(id) - progress.timesDropped(id) - progress.timesCrafted(enderEye))
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
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
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
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
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
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
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
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        completed = count > 0
    }
}

class FermentedEye: StatisticIndicator {
    var id: String = "minecraft:fermented_spider_eye"
    var key: String = L10n.Statistic.fermentedEye
    var name: String = "Fermented Eye"
    var icon: String = "fermented_spider_eye"
    var completed: Bool = false
    
    static let shared = FermentedEye()
    
    func update(progress: ProgressManager) {
        let count = progress.timesCrafted(id)
        completed = count > 0
    }
}

class GodlyApple: StatisticIndicator {
    var id: String = "minecraft:recipes/misc/mojang_banner_pattern"
    var key: String = L10n.Statistic.godApple
    var name: String = "God Apple"
    var icon: String = "enchanted_golden_apple"
    var completed: Bool = false
    
    static let shared = GodlyApple()
    
    func update(progress: ProgressManager) {
        completed = progress.advancementCompleted(id)
    }
}

class NetheriteUpgrade: StatisticIndicator {
    var id: String = "minecraft:recipes/misc/netherite_upgrade_smithing_template"
    var key: String = L10n.Statistic.upgradeNetherite
    var name: String = "Netherite Up"
    var icon: String = "upgrade_netherite"
    var completed: Bool = false
    
    static let shared = NetheriteUpgrade()
    
    func update(progress: ProgressManager) {
        completed = progress.advancementCompleted(id)
    }
}

class PotterySherds: StatisticIndicator {
    var id: String = "minecraft:pottery_sherd"
    var key: String = L10n.Statistic.potterySherds(0)
    var name: String = "0 / 4 Sherds"
    var icon: String = "pottery_sherd"
    var completed: Bool = false
    
    static let shared = PotterySherds()
    
    private let sherds = [
        "minecraft:angler_pottery_sherd",
        "minecraft:archer_pottery_sherd",
        "minecraft:arms_up_pottery_sherd",
        "minecraft:blade_pottery_sherd",
        "minecraft:brewer_pottery_sherd",
        "minecraft:burn_pottery_sherd",
        "minecraft:danger_pottery_sherd",
        "minecraft:explorer_pottery_sherd",
        "minecraft:friend_pottery_sherd",
        "minecraft:heart_pottery_sherd",
        "minecraft:heartbreak_pottery_sherd",
        "minecraft:howl_pottery_sherd",
        "minecraft:miner_pottery_sherd",
        "minecraft:mourner_pottery_sherd",
        "minecraft:plenty_pottery_sherd",
        "minecraft:prize_pottery_sherd",
        "minecraft:sheaf_pottery_sherd",
        "minecraft:shelter_pottery_sherd",
        "minecraft:skull_pottery_sherd",
        "minecraft:snort_pottery_sherd"
    ]
    
    func update(progress: ProgressManager) {
        let count = sherds.map({ getCount(id: $0, progress: progress) }).reduce(0, +)
        completed = count >= 4
        key = L10n.Statistic.potterySherds(count)
    }
    
    private func getCount(id: String, progress: ProgressManager) -> Int {
        return max(0, progress.timesPickedUp(id) - progress.timesDropped(id))
    }
}
