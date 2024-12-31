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
    private let surge = "minecraft:adventure/lightning_rod_with_villager_no_fire"
    
    func update(progress: ProgressManager) {
        let thunderDone = hasAdvancements(progress: progress)
        completed = progress.timesPickedUp(id) > 0 || thunderDone
        key = thunderDone ? L10n.Statistic.Trident.thunder : ((completed) ? L10n.Statistic.Trident.awaiting : L10n.Statistic.Trident.obtain)
    }
    
    @MainActor private func hasAdvancements(progress: ProgressManager) -> Bool {
        if !progress.advancementCompleted(veryFrightening) {
            return false
        }
        
        return [.v1_16, .v1_16_5].contains(TrackerManager.shared.gameVersion) || progress.advancementCompleted(surge)
    }
}
