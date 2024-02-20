//
//  StatusIndicators.swift
//  SwiftAA
//
//  Created by Kihron on 7/21/22.
//

import SwiftUI

class GodApple: TransferableIndicator, StatusIndicator {
    var type: StatusType = .godApple
    var id: String = "minecraft:recipes/misc/mojang_banner_pattern"
    var key: String = L10n.Statistic.GodApple.obtain
    var name: String = "Obtain God Apple"
    var icon: String = "enchanted_golden_apple"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    func update(progress: ProgressManager) {
        completed = progress.advancementCompleted(id)
        key = completed ? L10n.Statistic.GodApple.obtained : L10n.Statistic.GodApple.obtain
    }
}

class Trident: TransferableIndicator, StatusIndicator {
    var type: StatusType = .trident
    var id: String = "minecraft:trident"
    var key: String = L10n.Statistic.Trident.obtain
    var name: String = "Obtain\nTrident"
    var icon: String = "throw_trident"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    private let veryFrightening = "minecraft:adventure/very_very_frightening"
    
    func update(progress: ProgressManager) {
        let thunderDone = progress.advancementCompleted(veryFrightening)
        completed = progress.timesPickedUp(id) > 0
        key = thunderDone ? L10n.Statistic.Trident.thunder : ((completed) ? L10n.Statistic.Trident.awaiting : L10n.Statistic.Trident.obtain)
    }
}

class Shells: TransferableIndicator, StatusIndicator {
    var type: StatusType = .shells
    var id: String = "minecraft:nautilus_shell"
    var key: String = L10n.Statistic.shells(0)
    var name: String = "Shells\n0 / 8"
    var icon: String = "nautilus_shell"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    private let conduit = "minecraft:conduit"
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        let conduitCrafted = progress.timesCrafted(conduit) > 0
        completed = count >= 8 || conduitCrafted
        key = conduitCrafted ? L10n.Statistic.Shells.crafted : L10n.Statistic.shells(count)
    }
}

class WitherSkulls: TransferableIndicator, StatusIndicator {
    var type: StatusType = .witherSkulls
    var id: String = "minecraft:wither_skeleton_skull"
    var key: String = L10n.Statistic.Wither.skulls(0)
    var name: String = "Skulls\n0 / 3"
    var icon: String = "get_wither_skull"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    private let wither = "minecraft:wither"
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        let witherKilled = progress.wasKilled(wither)
        completed = count >= 3
        key = witherKilled ? L10n.Statistic.Wither.killed : L10n.Statistic.Wither.skulls(count)
    }
}

class AncientDebris: TransferableIndicator, StatusIndicator {
    var type: StatusType = .ancientDebris
    var id: String = "minecraft:ancient_debris"
    var key: String = L10n.Statistic.ancientDebris(0, 0)
    var name: String = "Debris: 0\nTNT: 0"
    var icon: String = "obtain_ancient_debris"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    private let netheriteAdvs = ["minecraft:nether/obtain_ancient_debris", "minecraft:nether/netherite_armor", "minecraft:husbandry/obtain_netherite_hoe"]
    private let tnt = "minecraft:tnt"
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        let countTNT = progress.timesMined(tnt) - progress.timesUsed(tnt)
        let doneWithNetherite = netheriteAdvs.allSatisfy({ adv in progress.advancementCompleted(adv) })

        completed = count >= 20 || doneWithNetherite
        key = (doneWithNetherite) ? L10n.Statistic.AncientDebris.done : L10n.Statistic.ancientDebris(count, countTNT)
    }
}

class Beehives: TransferableIndicator, StatusIndicator {
    var type: StatusType = .beehives
    var id: String = "minecraft:bee_nest"
    var key: String = L10n.Statistic.beehives(0)
    var name: String = "Hives: 0"
    var icon: String = "silk_touch_nest"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    private let honeyAdvs = ["minecraft:husbandry/safely_harvest_honey", "minecraft:adventure/honey_block_slide", "minecraft:husbandry/silk_touch_nest"]
    private let balancedDiet = "minecraft:husbandry/balanced_diet"
    private let honeyBottle = "honey_bottle"
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        let doneWithDiet = progress.criterionCompleted(advancement: balancedDiet, criterion: honeyBottle) != nil
        let doneWithHoney = honeyAdvs.allSatisfy({ adv in progress.advancementCompleted(adv) })
        
        completed = doneWithHoney && doneWithDiet
        key = completed ? L10n.Statistic.Beehives.done : L10n.Statistic.beehives(count)
    }
}

class GoldBlocks: TransferableIndicator, StatusIndicator {
    var type: StatusType = .goldBlocks
    var id: String = "minecraft:gold_block"
    var key: String = L10n.Statistic.goldBlocks(0)
    var name: String = "Gold Blocks\n0 / 164"
    var icon: String = "gold_block"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    private let goldIngot = "minecraft:gold_ingot"
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id) - (progress.timesCrafted(goldIngot) / 9) + progress.timesCrafted(id)
        completed = count >= 164
        key = L10n.Statistic.goldBlocks(count)
    }
}

class SnifferEggs: TransferableIndicator, StatusIndicator {
    var type: StatusType = .snifferEggs
    var id: String = "minecraft:sniffer_egg"
    var key: String = L10n.Statistic.snifferEggs(0)
    var name: String = "Gold Blocks\n0 / 164"
    var icon: String = "obtain_sniffer_egg"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        completed = count >= 3
        key = L10n.Statistic.snifferEggs(count)
    }
}

class MajorBiomes: TransferableIndicator, StatusIndicator {
    var type: StatusType = .majorBiomes
    var id: String = "minecraft:biome"
    var key: String = L10n.Statistic.majorBiomes(0, 5)
    var name: String = "Major Biomes\n0 / 5"
    var icon: String = "adventuring_time"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    private let biomeGroups: [String:[[String]]] = {
        let file = "major_biomes"
        let bundle = Bundle.main.url(forResource: file, withExtension: "json")!;
        return try! JSONDecoder().decode([String:[[String]]].self, from: Data(contentsOf: bundle))
    }()
    
    let adventuringTime = "minecraft:adventure/adventuring_time"
    
    func update(progress: ProgressManager) {
        if let groups = biomeGroups[TrackerManager.shared.gameVersion.label] {
            var count = 0
            var icons = [String]()
            
            for group in groups {
                let groupComplete = group.allSatisfy({progress.criterionCompleted(advancement: adventuringTime, criterion: "minecraft:\($0)") != nil})
                if groupComplete {
                    count += 1
                    icons.append(group[0])
                }
            }
            
            key = L10n.Statistic.majorBiomes(count, groups.count)
            icon = count == groups.count ? "explore_nether" : icons.isEmpty ? "adventuring_time" : icons.prefix(4).joined(separator: "+")
            completed = count == groups.count
        }
    }
}
