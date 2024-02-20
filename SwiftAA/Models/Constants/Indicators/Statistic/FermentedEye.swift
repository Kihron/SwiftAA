//
//  FermentedEye.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class FermentedEye: StatisticIndicator {
    var id: String = "minecraft:fermented_spider_eye"
    var key: String = L10n.Statistic.fermentedEye
    var name: String = "Fermented Eye"
    var icon: String = "fermented_spider_eye"
    var completed: Bool = false
    
    static let shared = FermentedEye()
    
    func update(progress: ProgressManager) {
        let count = progress.timesCrafted(id)
        completed = count > 0
    }
}
