//
//  Statistics.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/21/22.
//

import SwiftUI

class GodApple: Indicator {
    var id: String = "minecraft:recipes/misc/mojang_banner_pattern"
    var key: String = "stats-god-apple"
    var name: String = "Obtain God Apple"
    var icon: String = "enchanted_golden_apple"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        self.completed = (advancements[id] != nil)
        self.name = (self.completed) ? "Obtained God Apple" : "Obtain God Apple"
    }
}

class Trident: Indicator {
    var id: String = "minecraft:trident"
    var key: String = "stats-trident"
    var name: String = "Obtain\nTrident"
    var icon: String = "throw_trident"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        self.completed = (stats["minecraft:picked_up"]?[id] ?? 0) > 0
        let thunderDone = advancements["minecraft:adventure/very_very_frightening"]?.done ?? false
        self.name = thunderDone ? "Done With Thunder" : ((self.completed) ? "Awaiting\nThunder" : "Obtain\nTrident")
    }
}

class Shells: Indicator {
    var id: String = "minecraft:nautilus_shell"
    var key: String = "stats-shells"
    var name: String = "Shells\n0 / 8"
    var icon: String = "nautilus_shell"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = stats["minecraft:picked_up"]?[id] ?? 0
        let conduitCrafted = (stats["minecraft:crafted"]?["minecraft:conduit"] ?? 0) > 0
        self.completed = count >= 8 || conduitCrafted
        self.name = conduitCrafted ? "Conduit Crafted" : "Shells\n\(count) / 8"
    }
}

class WitherSkulls: Indicator {
    var id: String = "minecraft:wither_skeleton_skull"
    var key: String = "stats-wither-skulls"
    var name: String = "Skulls\n0 / 3"
    var icon: String = "get_wither_skull"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = stats["minecraft:picked_up"]?[id] ?? 0
        let witherKilled = (stats["minecraft:killed"]?["minecraft:wither"] ?? 0) > 0
        self.completed = count >= 3
        self.name = witherKilled ? "Wither Has Been Killed" : "Skulls\n\(count) / 3"
    }
}

class AncientDebris: Indicator {
    var id: String = "minecraft:ancient_debris"
    var key: String = "stats-ancient-debris"
    var name: String = "Debris: 0\nTNT: 0"
    var icon: String = "obtain_ancient_debris"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var offset: Int = 0
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        let count = (stats["minecraft:picked_up"]?[id] ?? 0) + offset
        let countTNT = (stats["minecraft:mined"]?["minecraft:tnt"] ?? 0) - (stats["minecraft:used"]?[id] ?? 0)
        let netheriteAdvs = ["minecraft:nether/obtain_ancient_debris", "minecraft:nether/netherite_armor", "minecraft:husbandry/obtain_netherite_hoe"]
        let doneWithNetherite = netheriteAdvs.allSatisfy { adv in
            return advancements[adv]?.done ?? false
        }
        
        self.completed = count >= 20 || doneWithNetherite
        self.name = (doneWithNetherite) ? "Done With Netherite" : "Debris: \(count)\nTNT: \(countTNT)"
    }
}
