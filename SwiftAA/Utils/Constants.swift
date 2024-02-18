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
        EnderPearls.shared,
        NetherWart.shared,
        GhastTears.shared,
        Pufferfish.shared,
        AzureBluet.shared,
        FermentedEye.shared
    ]
    
    static let ambigiousCriteria = ["hoglin", "tuxedo", "cat"]
    
    static let defaultActiveStatusIndicators: String = "minecraft:recipes/misc/mojang_banner_pattern,minecraft:trident,minecraft:nautilus_shell,minecraft:wither_skeleton_skull,minecraft:ancient_debris,minecraft:bee_nest"
}
