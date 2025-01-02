//
//  WitherSkulls.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

@Observable
class WitherSkulls: TransferableIndicator, StatusIndicator {
    var type: StatusType = .witherSkulls
    var id: String = "minecraft:wither_skeleton_skull"
    var key: String = L10n.Statistic.Wither.skulls(0)
    var name: String = "Skulls\n0 / 3"
    var icon: String = "get_wither_skull"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    private let wither = "minecraft:wither"
    private let mobsKilled = "minecraft:adventure/kill_all_mobs"
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        let witherKilled = progress.criterionCompleted(mobsKilled, wither) != nil
        completed = count >= 3 || witherKilled
        key = witherKilled ? L10n.Statistic.Wither.killed : L10n.Statistic.Wither.skulls(count)
    }
}
