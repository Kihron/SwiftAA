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
        SnifferEggs()
    ]
    
    static let defaultActiveStatusIndicators: String = "minecraft:recipes/misc/mojang_banner_pattern,minecraft:trident,minecraft:nautilus_shell,minecraft:wither_skeleton_skull,minecraft:ancient_debris,minecraft:bee_nest"
}