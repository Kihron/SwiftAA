//
//  Constants.swift
//  SwiftAA
//
//  Created by Kihron on 10/22/23.
//

import SwiftUI

class Constants {
    static let statusIndicators: [Indicator] = [
        GodApple(),
        Trident(),
        Shells(),
        WitherSkulls(),
        AncientDebris(),
        Beehives(),
        GoldBlocks(),
        SnifferEggs(),
        MajorBiomes()
    ]
    
    static let statisticIndicators: [StatisticIndicator] = [
        GodlyApple.shared,
        EnderPearls.shared,
        NetherWart.shared,
        GhastTears.shared,
        Pufferfish.shared,
        AzureBluet.shared,
        FermentedEye.shared,
        NetheriteUpgrade.shared,
        PotterySherds.shared
    ]
    
    static let finalStatistics: [FinalStatistic] = [
        FinalStatistic(id: "minecraft:aviate_one_cm", type: "minecraft:custom", factor: 100_000, icon: "rockets", secondaryIcon: "elytra", tooltip: L10n.Overlay.Complete.Stat.elytra, flipped: true),
        FinalStatistic(id: "minecraft:bread", type: "minecraft:used", icon: "heal", secondaryIcon: "bread", tooltip: L10n.Overlay.Complete.Stat.bread),
        FinalStatistic(id: "minecraft:enchant_item", type: "minecraft:custom", icon: "lapis_lazuli", secondaryIcon: "enchantment_table", tooltip: L10n.Overlay.Complete.Stat.enchant),
        FinalStatistic(id: "minecraft:ender_pearl", type: "minecraft:used", icon: "ender_pearl", secondaryIcon: "ender_pearl", tooltip: L10n.Overlay.Complete.Stat.pearl, flipped: true),
        FinalStatistic(id: "minecraft:tnt", type: "minecraft:mined", factor: 9, icon: "tnt", secondaryIcon: "sandstone", tooltip: L10n.Overlay.Complete.Stat.temples),
        FinalStatistic(id: "minecraft:creeper", type: "minecraft:killed", icon: "kill_all_mobs", secondaryIcon: "creeper"),
        FinalStatistic(id: "minecraft:drowned", type: "minecraft:killed", icon: "kill_all_mobs", secondaryIcon: "drowned"),
        FinalStatistic(id: "minecraft:wither_skeleton", type: "minecraft:killed", icon: "kill_all_mobs", secondaryIcon: "wither_skeleton"),
        FinalStatistic(id: "minecraft:cod", type: "minecraft:killed", icon: "diamond_axe", secondaryIcon: "cod"),
        FinalStatistic(id: "minecraft:salmon", type: "minecraft:killed", icon: "diamond_axe", secondaryIcon: "salmon"),
        FinalStatistic(id: "minecraft:netherrack", type: "minecraft:mined", icon: "diamond_pickaxe", secondaryIcon: "netherrack"),
        FinalStatistic(id: "minecraft:gold_block", type: "minecraft:mined", icon: "diamond_pickaxe", secondaryIcon: "gold_block"),
        FinalStatistic(id: "minecraft:ender_chest", type: "minecraft:mined", icon: "diamond_pickaxe", secondaryIcon: "ender_chest"),
        FinalStatistic(id: "minecraft:lectern", type: "minecraft:mined", icon: "diamond_axe", secondaryIcon: "lectern"),
        FinalStatistic(id: "minecraft:sugar_cane", type: "minecraft:picked_up", icon: "diamond_axe", secondaryIcon: "sugarcane")
    ]
    
    static let ambigiousCriteria = ["hoglin", "tuxedo", "cat"]
    
    static let animatedIcons = ["enchanted_golden_apple", "enchant_item", "skulk_sensor", "summon_wither"]
    
    static var gifCache: [String: (frames: [NSImage], durations: [TimeInterval])] = [:]
    
    static let defaultActiveStatusIndicators: String = "minecraft:recipes/misc/mojang_banner_pattern,minecraft:trident,minecraft:nautilus_shell,minecraft:wither_skeleton_skull,minecraft:ancient_debris,minecraft:bee_nest"
    
    static let dataVersionRegex = try! NSRegularExpression(pattern: ",\\s*\"DataVersion\"\\s*:\\s*\\d*|\"DataVersion\"\\s*:\\s*\\d*\\s*,?")
    
    static let versionRegex = try! NSRegularExpression(pattern: "minecraft-(.*?)-client\\.jar")
}
