//
//  NetherWart.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class NetherWart: StatisticIndicator {
    var id: String = "minecraft:nether_wart"
    var key: String = L10n.Statistic.netherWart(0)
    var name: String = "0 Wart"
    var icon: String = "nether_wart"
    var completed: Bool = false
    
    static let shared = NetherWart()
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        completed = count >= 3
        key = L10n.Statistic.netherWart(count)
    }
}
