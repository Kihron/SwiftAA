//
//  Statistics.swift
//  SwiftAA
//
//  Created by Kihron on 7/21/22.
//

import SwiftUI

class GodApple: Indicator {
    var id: String = "minecraft:recipes/misc/mojang_banner_pattern"
    var key: String = "stat-god-apple-obtain".localized
    var name: String = "Obtain God Apple"
    var icon: String = "enchanted_golden_apple"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        completed = (advancements[id] != nil)
        key = (completed) ? "stat-god-apple-obtained".localized : "stat-god-apple-obtain".localized
    }
}

class Trident: Indicator {
    var id: String = "minecraft:trident"
    var key: String = "stat-trident-obtain".localized
    var name: String = "Obtain\nTrident"
    var icon: String = "throw_trident"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        completed = (stats["minecraft:picked_up"]?[id] ?? 0) > 0
        let thunderDone = advancements["minecraft:adventure/very_very_frightening"]?.done ?? false
        key = thunderDone ? "stat-trident-thunder".localized : ((completed) ? "stat-trident-awaiting".localized : "stat-trident-obtain".localized)
    }
}

class Shells: Indicator {
    var id: String = "minecraft:nautilus_shell"
    var key: String = "stat-shells".localized(["0"])
    var name: String = "Shells\n0 / 8"
    var icon: String = "nautilus_shell"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = stats["minecraft:picked_up"]?[id] ?? 0
        let conduitCrafted = (stats["minecraft:crafted"]?["minecraft:conduit"] ?? 0) > 0
        completed = count >= 8 || conduitCrafted
        key = conduitCrafted ? "stat-shells-crafted".localized : "stat-shells".localized(["\(count)"])
    }
}

class WitherSkulls: Indicator {
    var id: String = "minecraft:wither_skeleton_skull"
    var key: String = "stat-wither-skulls".localized(["0"])
    var name: String = "Skulls\n0 / 3"
    var icon: String = "get_wither_skull"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = stats["minecraft:picked_up"]?[id] ?? 0
        let witherKilled = (stats["minecraft:killed"]?["minecraft:wither"] ?? 0) > 0
        completed = count >= 3
        key = witherKilled ? "stat-wither-killed".localized : "stat-wither-skulls".localized(["\(count)"])
    }
}

class AncientDebris: Indicator {
    var id: String = "minecraft:ancient_debris"
    var key: String = "stat-ancient-debris".localized(["0", "0"])
    var name: String = "Debris: 0\nTNT: 0"
    var icon: String = "obtain_ancient_debris"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var offset: Int = 0
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = (stats["minecraft:picked_up"]?[id] ?? 0) + offset
        let countTNT = (stats["minecraft:mined"]?["minecraft:tnt"] ?? 0) - (stats["minecraft:used"]?[id] ?? 0)
        let netheriteAdvs = ["minecraft:nether/obtain_ancient_debris", "minecraft:nether/netherite_armor", "minecraft:husbandry/obtain_netherite_hoe"]
        let doneWithNetherite = netheriteAdvs.allSatisfy({ adv in advancements[adv]?.done ?? false })

        completed = count >= 20 || doneWithNetherite
        key = (doneWithNetherite) ? "stat-ancient-debris-done".localized : "stat-ancient-debris".localized(["\(count)", "\(countTNT)"])
    }
}
