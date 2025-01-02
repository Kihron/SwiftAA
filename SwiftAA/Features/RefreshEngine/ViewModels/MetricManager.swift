//
//  MetricManager.swift
//  SwiftAA
//
//  Created by Kihron on 1/1/25.
//

import SwiftUI

@MainActor @Observable class MetricManager {
    var statusIndicators: [Indicator] = [
        GodApple(),
        Trident(),
        Shells(),
        WitherSkulls(),
        AncientDebris(),
        Beehives(),
        GoldBlocks(),
        SnifferEggs(),
        MajorBiomes(),
        HeavyCore(),
    ]

    var statisticIndicators: [StatisticIndicator] = [
        GodlyApple.shared,
        EnderPearls.shared,
        NetherWart.shared,
        GhastTears.shared,
        Pufferfish.shared,
        AzureBluet.shared,
        FermentedEye.shared,
        NetheriteUpgrade.shared,
        PotterySherds.shared,
        HeavilyCore.shared,
    ]

    static let shared = MetricManager()

    private init() {}

    func getSpecificStats(types: [StatusType]) -> Binding<[Indicator]> {
        if let array = statusIndicators as? [StatusIndicator] {
            let filteredIndicators = array.filter { indicator in
                types.contains(indicator.type)
            }

            return .constant(filteredIndicators.sorted { (indicator1, indicator2) -> Bool in
                guard let index1 = types.firstIndex(of: indicator1.type), let index2 = types.firstIndex(of: indicator2.type) else {
                    return false
                }
                return index1 < index2
            })
        }
        return .constant(statusIndicators)
    }
}
