//
//  StatusIndicators.swift
//  SwiftAA
//
//  Created by Kihron on 7/21/22.
//

import SwiftUI

class GodApple: Indicator {
    var id: String = "minecraft:recipes/misc/mojang_banner_pattern"
    var key: String = L10n.Statistic.GodApple.obtain
    var name: String = "Obtain God Apple"
    var icon: String = "enchanted_golden_apple"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        completed = advancements[id] != nil
        key = completed ? L10n.Statistic.GodApple.obtained : L10n.Statistic.GodApple.obtain
    }
}

class Trident: Indicator {
    var id: String = "minecraft:trident"
    var key: String = L10n.Statistic.Trident.obtain
    var name: String = "Obtain\nTrident"
    var icon: String = "throw_trident"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        completed = (stats["minecraft:picked_up"]?[id] ?? 0) > 0
        let thunderDone = advancements["minecraft:adventure/very_very_frightening"]?.done ?? false
        key = thunderDone ? L10n.Statistic.Trident.thunder : ((completed) ? L10n.Statistic.Trident.awaiting : L10n.Statistic.Trident.obtain)
    }
}

class Shells: Indicator {
    var id: String = "minecraft:nautilus_shell"
    var key: String = L10n.Statistic.shells(0)
    var name: String = "Shells\n0 / 8"
    var icon: String = "nautilus_shell"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = stats["minecraft:picked_up"]?[id] ?? 0
        let conduitCrafted = (stats["minecraft:crafted"]?["minecraft:conduit"] ?? 0) > 0
        completed = count >= 8 || conduitCrafted
        key = conduitCrafted ? L10n.Statistic.Shells.crafted : L10n.Statistic.shells(count)
    }
}

class WitherSkulls: Indicator {
    var id: String = "minecraft:wither_skeleton_skull"
    var key: String = L10n.Statistic.Wither.skulls(0)
    var name: String = "Skulls\n0 / 3"
    var icon: String = "get_wither_skull"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = stats["minecraft:picked_up"]?[id] ?? 0
        let witherKilled = (stats["minecraft:killed"]?["minecraft:wither"] ?? 0) > 0
        completed = count >= 3
        key = witherKilled ? L10n.Statistic.Wither.killed : L10n.Statistic.Wither.skulls(count)
    }
}

class AncientDebris: Indicator {
    var id: String = "minecraft:ancient_debris"
    var key: String = L10n.Statistic.ancientDebris(0, 0)
    var name: String = "Debris: 0\nTNT: 0"
    var icon: String = "obtain_ancient_debris"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var offset: Int = 0
    var tooltip: String = ""
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = (stats["minecraft:picked_up"]?[id] ?? 0) + offset
        let countTNT = (stats["minecraft:mined"]?["minecraft:tnt"] ?? 0) - (stats["minecraft:used"]?[id] ?? 0)
        let netheriteAdvs = ["minecraft:nether/obtain_ancient_debris", "minecraft:nether/netherite_armor", "minecraft:husbandry/obtain_netherite_hoe"]
        let doneWithNetherite = netheriteAdvs.allSatisfy({ adv in advancements[adv]?.done ?? false })

        completed = count >= 20 || doneWithNetherite
        key = (doneWithNetherite) ? L10n.Statistic.AncientDebris.done : L10n.Statistic.ancientDebris(count, countTNT)
    }
}

class Beehives: Indicator {
    var id: String = "minecraft:bee_nest"
    var key: String = L10n.Statistic.beehives(0)
    var name: String = "Hives: 0"
    var icon: String = "silk_touch_nest"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = stats["minecraft:picked_up"]?[id] ?? 0
        let honeyAdvs = ["minecraft:husbandry/safely_harvest_honey", "minecraft:adventure/honey_block_slide", "minecraft:husbandry/silk_touch_nest"]
        let doneWithDiet = advancements["minecraft:husbandry/balanced_diet"]?.criteria["honey_bottle"] != nil
        let doneWithHoney = honeyAdvs.allSatisfy({ adv in advancements[adv]?.done ?? false })
        
        completed = doneWithHoney && doneWithDiet
        key = completed ? L10n.Statistic.Beehives.done : L10n.Statistic.beehives(count)
    }
}
