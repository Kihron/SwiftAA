//
//  NetheriteUpgrade.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class NetheriteUpgrade: StatisticIndicator {
    var id: String = "minecraft:recipes/misc/netherite_upgrade_smithing_template"
    var key: String = L10n.Statistic.upgradeNetherite
    var name: String = "Netherite Up"
    var icon: String = "upgrade_netherite"
    var completed: Bool = false
    
    static let shared = NetheriteUpgrade()
    
    func update(progress: ProgressManager) {
        completed = progress.advancementCompleted(id)
    }
}
