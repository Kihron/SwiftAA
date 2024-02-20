//
//  Pufferfish.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class Pufferfish: StatisticIndicator {
    var id: String = "minecraft:pufferfish"
    var key: String = L10n.Statistic.pufferfish(0)
    var name: String = "0 / 2 Puffers"
    var icon: String = "pufferfish"
    var completed: Bool = false
    
    static let shared = Pufferfish()
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        completed = count >= 2
        key = L10n.Statistic.pufferfish(count)
    }
}
