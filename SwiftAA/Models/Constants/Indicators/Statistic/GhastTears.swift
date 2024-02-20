//
//  GhastTears.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class GhastTears: StatisticIndicator {
    var id: String = "minecraft:ghast_tear"
    var key: String = L10n.Statistic.ghastTears(0)
    var name: String = "0 / 4 Tears"
    var icon: String = "ghast_tear"
    var completed: Bool = false
    
    static let shared = GhastTears()
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        completed = count >= 4
        key = L10n.Statistic.ghastTears(count)
    }
}
