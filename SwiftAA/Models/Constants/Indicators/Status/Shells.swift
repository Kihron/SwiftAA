//
//  Shells.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class Shells: TransferableIndicator, StatusIndicator {
    var type: StatusType = .shells
    var id: String = "minecraft:nautilus_shell"
    var key: String = L10n.Statistic.shells(0)
    var name: String = "Shells\n0 / 8"
    var icon: String = "nautilus_shell"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    private let conduit = "minecraft:conduit"
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        let conduitCrafted = progress.timesCrafted(conduit) > 0
        completed = count >= 8 || conduitCrafted
        key = conduitCrafted ? L10n.Statistic.Shells.crafted : L10n.Statistic.shells(count)
    }
}
