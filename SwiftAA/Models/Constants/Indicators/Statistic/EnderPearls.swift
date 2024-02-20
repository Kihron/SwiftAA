//
//  EnderPearls.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class EnderPearls: StatisticIndicator {
    var id: String = "minecraft:ender_pearl"
    var key: String = L10n.Statistic.enderPearl(0)
    var name: String = "0 Pearls"
    var icon: String = "ender_pearl"
    var completed: Bool = false
    
    static let shared = EnderPearls()
    
    private let enderEye = "minecraft:ender_eye"
    
    func update(progress: ProgressManager) {
        let estimate = max(0, progress.timesPickedUp(id) - progress.timesUsed(id) - progress.timesDropped(id) - progress.timesCrafted(enderEye))
        completed = estimate > 0
        key = L10n.Statistic.enderPearl(estimate)
    }
}
