//
//  HeavyCore.swift
//  SwiftAA
//
//  Created by Andrew on 12/29/24.
//

class HeavyCore: TransferableIndicator, StatusIndicator {
    var type: StatusType = .heavyCore
    var id: String = "minecraft:heavy_core"
    var key: String = L10n.Statistic.Trident.obtain
    var name: String = "Obtain\nHeavy Core"
    var icon: String = "heavy_core"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    func update(progress: ProgressManager) {
        completed = progress.timesPickedUp(id) > 0
        key = completed ? L10n.Statistic.HeavyCore.obtained : L10n.Statistic.HeavyCore.obtain
    }
}
