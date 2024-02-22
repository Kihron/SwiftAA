//
//  L1_20S.swift
//  SwiftAA
//
//  Created by Kihron on 2/16/24.
//

import SwiftUI

struct L1_20S: View {
    @ObservedObject private var dataManager = DataManager.shared
    
    @State private var topStats = Utilities.getSpecificStats(types: [.trident, .shells, .snifferEggs])
    @State private var bottomStats = Utilities.getSpecificStats(types: [.witherSkulls, .goldBlocks])
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            AdvPanelView(indicators: dataManager.decode(file: "minecraft", start: "minecraft:story/mine_stone"), columnCount: 5)
                                .frame(width: 350)
                            AdvPanelView(indicators: dataManager.decode(file: "nether"), columnCount: 8)
                                .frame(width: 540)
                            AdvPanelView(indicators: dataManager.decode(file: "husbandry", start: "minecraft:husbandry/froglights"), columnCount: 1)
                                .frame(width: 74)
                            AdvPanelView(indicators: dataManager.decode(file: "adventure", start: "minecraft:adventure/spyglass_at_parrot", end: "minecraft:adventure/spyglass_at_dragon"), columnCount: 1)
                                .frame(width: 74)
                            AdvPanelView(indicators: dataManager.decode(file: "adventure", start: "minecraft:adventure/sleep_in_bed", end: "minecraft:adventure/trim_with_all_exclusive_armor_patterns"), columnCount: 6)
                                .frame(width: 437)
                            AdvPanelView(indicators: $topStats, columnCount: 1, isStat: true)
                                .frame(width: 75)
                        }
                        
                        HStack(spacing: 0) {
                            AdvPanelView(indicators: dataManager.decode(file: "end", start: "minecraft:end/kill_dragon"), columnCount: 4)
                                .frame(width: 276)
                            AdvPanelView(indicators: dataManager.decode(file: "husbandry", start: "minecraft:husbandry/plant_seed", end: "minecraft:husbandry/obtain_netherite_hoe"), columnCount: 11)
                                .frame(width: 762)
                            AdvPanelView(indicators: dataManager.decode(file: "adventure", start: "minecraft:adventure/honey_block_slide"), columnCount: 6)
                                .frame(width: 437)
                            AdvPanelView(indicators: $bottomStats, columnCount: 1, isStat: true)
                                .frame(width: 75)
                        }
                    }
                    
                    InfoPanelView()
                        .frame(width: 196, height: 431)
                }
                
                HStack(spacing: 0) {
                    GoalPanelView(advancement: dataManager.decode(file: "adventure")[33].asAdvancement, rowCount: 16, goal: L10n.Goal.biomesVisited)
                        .frame(width: 521)
                    GoalPanelView(advancement: dataManager.decode(file: "adventure")[34].asAdvancement, rowCount: 16, goal: L10n.Goal.monstersKilled)
                        .frame(width: 337)
                    GoalPanelView(advancement: dataManager.decode(file: "husbandry")[20].asAdvancement, rowCount: 16, goal: L10n.Goal.foodsEaten)
                        .frame(width: 325)
                    GoalPanelView(advancement: dataManager.decode(file: "husbandry")[19].asAdvancement, rowCount: 16, goal: L10n.Goal.animalsBred)
                        .frame(width: 193)
                    GoalPanelView(advancement: dataManager.decode(file: "husbandry")[21].asAdvancement, rowCount: 16, goal: L10n.Goal.cats)
                        .frame(width: 138)
                    
                    VStack(spacing: 0) {
                        GoalPanelView(advancement: dataManager.decode(file: "adventure")[18].asAdvancement, rowCount: 8, goal: L10n.Goal.trims, isAdjacent: true)
                            .frame(height: 193)
                        
                        GoalPanelView(advancement: dataManager.decode(file: "nether")[9].asAdvancement, rowCount: 5, goal: L10n.Goal.nether, isAdjacent: true)
                            .frame(height: 145)
                    }
                    .frame(width: 232)
                }
                .frame(width: 1746, height: 338)
            }
        }
    }
}

#Preview {
    L1_20S()
}
