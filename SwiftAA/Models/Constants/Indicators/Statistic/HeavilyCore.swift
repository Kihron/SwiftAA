//
//  HeavilyCore.swift
//  SwiftAA
//
//  Created by Andrew on 12/29/24.
//

class HeavilyCore: StatisticIndicator {
    var id: String = "minecraft:heavy_core"
    var key: String = L10n.Statistic.heavyCore
    var name: String = "Heavy Core"
    var icon: String = "heavy_core_stat"
    var completed: Bool = false
    
    static let shared = HeavilyCore()
    
    func update(progress: ProgressManager) {
        completed = progress.timesPickedUp(id) >= 1
        print("Updated", completed)
    }
}
