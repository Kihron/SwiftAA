//
//  AncientDebris.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

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
