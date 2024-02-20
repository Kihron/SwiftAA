//
//  Trident.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class Trident: TransferableIndicator, StatusIndicator {
    var type: StatusType = .trident
    var id: String = "minecraft:trident"
    var key: String = L10n.Statistic.Trident.obtain
    var name: String = "Obtain\nTrident"
    var icon: String = "throw_trident"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    private let veryFrightening = "minecraft:adventure/very_very_frightening"
    
    func update(progress: ProgressManager) {
        let thunderDone = progress.advancementCompleted(veryFrightening)
        completed = progress.timesPickedUp(id) > 0
        key = thunderDone ? L10n.Statistic.Trident.thunder : ((completed) ? L10n.Statistic.Trident.awaiting : L10n.Statistic.Trident.obtain)
    }
}
