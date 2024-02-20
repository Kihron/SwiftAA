//
//  AzureBluet.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class AzureBluet: StatisticIndicator {
    var id: String = "minecraft:azure_bluet"
    var key: String = L10n.Statistic.azureBluet
    var name: String = "Azure Bluet"
    var icon: String = "azure_bluet"
    var completed: Bool = false
    
    static let shared = AzureBluet()
    
    func update(progress: ProgressManager) {
        let count = progress.timesPickedUp(id)
        completed = count > 0
    }
}
