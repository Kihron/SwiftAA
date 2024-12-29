//
//  SnifferEggs.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class SnifferEggs: TransferableIndicator, StatusIndicator {
    var type: StatusType = .snifferEggs
    var id: String = "minecraft:sniffer_egg"
    var key: String = L10n.Statistic.snifferEggs(0)
    var name: String = "Sniffer Eggs\n0 / 2"
    var icon: String = "obtain_sniffer_egg"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    private let sniffer = "minecraft:sniffer"
    private let feedSnifflet = "minecraft:husbandry/feed_snifflet"
    private let plantingThePast = "minecraft:husbandry/plant_any_sniffer_seed"
    private let twoByTwo = "minecraft:husbandry/bred_all_animals"
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        let advancementsComplete = progress.advancementCompleted(feedSnifflet) && progress.advancementCompleted(plantingThePast) && progress.criterionCompleted(twoByTwo, sniffer) != nil
        
        completed = count >= 2 || advancementsComplete
        key = completed ? L10n.Statistic.SnifferEggs.done : L10n.Statistic.snifferEggs(count)
    }
}
