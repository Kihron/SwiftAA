//
//  L1_21S.swift
//  SwiftAA
//
//  Created by Slackow on 12/29/24.
//

import SwiftUI

struct L1_21S: View {
    @State private var topStats = Utilities.getSpecificStats(types: [.trident, .shells, .snifferEggs])
    @State private var bottomStats = Utilities.getSpecificStats(types: [.witherSkulls, .goldBlocks, .heavyCore])
    
    private var dataManager = DataManager.shared
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "minecraft", start: "minecraft:story/mine_stone"), columnCount: 5)
                                .frame(width: 350)
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "nether"), columnCount: 8)
                                .frame(width: 558)
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "adventure", start: "minecraft:adventure/root", end: "minecraft:adventure/trim_with_all_exclusive_armor_patterns"), columnCount: 7)
                                .frame(width: 480)
                            AdvPanelView(indicators: $topStats, columnCount: 1, isStat: true)
                                .frame(width: 75)
                        }
                        
                        HStack(spacing: 0) {
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "end", start: "minecraft:end/root"), columnCount: 3)
                                .frame(width: 212)
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "husbandry", start: "minecraft:husbandry/plant_seed", end: "minecraft:husbandry/obtain_netherite_hoe"), columnCount: 8)
                                .frame(width: 548)
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "husbandry", start: "minecraft:husbandry/froglights"), columnCount: 1)
                                .frame(width: 74)
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "adventure", start: "minecraft:adventure/spyglass_at_parrot", end: "minecraft:adventure/spyglass_at_dragon"), columnCount: 1)
                                .frame(width: 74)
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "adventure", start: "minecraft:adventure/avoid_vibration"), columnCount: 7)
                                .frame(width: 480)
                            AdvPanelView(indicators: $bottomStats, columnCount: 1, isStat: true)
                                .frame(width: 75)
                        }
                    }
                    
                    InfoPanelView()
                        .frame(width: 209, height: 514)
                }
                
                HStack(spacing: 0) {
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:adventure/adventuring_time"), rowCount: 16, goal: L10n.Goal.biomesVisited)
                        .frame(width: 494)
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:adventure/kill_all_mobs"), rowCount: 16, goal: L10n.Goal.monstersKilled)
                        .frame(width: 306)
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/balanced_diet"), rowCount: 16, goal: L10n.Goal.foodsEaten)
                        .frame(width: 315)
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/bred_all_animals"), rowCount: 16, goal: L10n.Goal.animalsBred, hidePercentage: true)
                        .frame(width: 168)
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/complete_catalogue"), rowCount: 16, goal: "", hidePercentage: true)
                        .frame(width: 90)
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/whole_pack"), rowCount: 16, goal: L10n.Goal.dogs, hidePercentage: true)
                        .frame(width: 90)
                    
                    VStack(spacing: 0) {
                        GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:adventure/trim_with_all_exclusive_armor_patterns"), rowCount: 8, goal: L10n.Goal.trims, isAdjacent: true)
                            .frame(height: 193)
                        
                        GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:nether/explore_nether"), rowCount: 5, goal: L10n.Goal.nether, isAdjacent: true)
                            .frame(height: 145)
                    }
                    .frame(width: 209)
                }
                .frame(width: 1672, height: 338)
            }
        }
    }
}

#Preview {
    L1_20S()
}
