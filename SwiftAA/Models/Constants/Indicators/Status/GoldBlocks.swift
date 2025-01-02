//
//  GoldBlocks.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

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
    private let beaconator = "minecraft:nether/create_full_beacon"
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id) - (progress.timesCrafted(goldIngot) / 9) + progress.timesCrafted(id)
        let beaconatorComplete = progress.advancementCompleted(beaconator)
        
        completed = count >= 164 || beaconatorComplete
        key = beaconatorComplete ? L10n.Statistic.GoldBlocks.beaconator : L10n.Statistic.goldBlocks(count)
    }
}
