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
