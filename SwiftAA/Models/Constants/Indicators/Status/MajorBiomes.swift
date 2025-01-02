//
//  MajorBiomes.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class MajorBiomes: TransferableIndicator, StatusIndicator {
    var type: StatusType = .majorBiomes
    var id: String = "minecraft:biome"
    var key: String = L10n.Statistic.majorBiomes(0, 5)
    var name: String = "Major Biomes\n0 / 5"
    var icon: String = "adventuring_time"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    private let biomeGroups: [String:[[String]]] = {
        let file = "major_biomes"
        let bundle = Bundle.main.url(forResource: file, withExtension: "json")!;
        return try! JSONDecoder().decode([String:[[String]]].self, from: Data(contentsOf: bundle))
    }()
    
    private let adventuringTime = "minecraft:adventure/adventuring_time"
    
    func update(progress: ProgressManager) {
        if let groups = biomeGroups[TrackerManager.shared.gameVersion.label] {
            var count = 0
            var icons = [String]()
            
            for group in groups {
                let groupComplete = group.allSatisfy({progress.criterionCompleted(adventuringTime, "minecraft:\($0)") != nil})
                if groupComplete {
                    count += 1
                    icons.append(group[0])
                }
            }
            let allBiomesFound = progress.advancementCompleted(adventuringTime)
            key = allBiomesFound ? L10n.Statistic.biomesCompleted : L10n.Statistic.majorBiomes(count, groups.count)
            icon = allBiomesFound ? "enchanted_netherite_boots" :
                    count == groups.count ? "explore_nether" :
                    icons.isEmpty ? "adventuring_time" :
                    icons.prefix(4).joined(separator: "+")
            completed = count == groups.count || allBiomesFound
            
        }
    }
}
