//
//  Beehives.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

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
        let doneWithDiet = progress.criterionCompleted(balancedDiet, honeyBottle) != nil
        let doneWithHoney = honeyAdvs.allSatisfy({ adv in progress.advancementCompleted(adv) })
        
        completed = doneWithHoney && doneWithDiet
        key = completed ? L10n.Statistic.Beehives.done : L10n.Statistic.beehives(count)
    }
}
