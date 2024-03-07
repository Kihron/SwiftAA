//
//  PotterySherds.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class PotterySherds: StatisticIndicator {
    var id: String = "minecraft:pottery_sherd"
    var key: String = L10n.Statistic.potterySherds(0)
    var name: String = "0 / 4 Sherds"
    var icon: String = "pottery_sherd"
    var completed: Bool = false
    
    static let shared = PotterySherds()
    
    private let sherds = [
        "minecraft:angler_pottery_sherd",
        "minecraft:archer_pottery_sherd",
        "minecraft:arms_up_pottery_sherd",
        "minecraft:blade_pottery_sherd",
        "minecraft:brewer_pottery_sherd",
        "minecraft:burn_pottery_sherd",
        "minecraft:danger_pottery_sherd",
        "minecraft:explorer_pottery_sherd",
        "minecraft:friend_pottery_sherd",
        "minecraft:heart_pottery_sherd",
        "minecraft:heartbreak_pottery_sherd",
        "minecraft:howl_pottery_sherd",
        "minecraft:miner_pottery_sherd",
        "minecraft:mourner_pottery_sherd",
        "minecraft:plenty_pottery_sherd",
        "minecraft:prize_pottery_sherd",
        "minecraft:sheaf_pottery_sherd",
        "minecraft:shelter_pottery_sherd",
        "minecraft:skull_pottery_sherd",
        "minecraft:snort_pottery_sherd"
    ]
    
    func update(progress: ProgressManager) {
        let count = sherds.map({ getCount(id: $0, progress: progress) }).reduce(0, +)
        completed = count >= 4
        key = L10n.Statistic.potterySherds(count)
    }
    
    private func getCount(id: String, progress: ProgressManager) -> Int {
        return max(0, progress.timesPickedUp(id) - progress.timesDropped(id))
    }
}
