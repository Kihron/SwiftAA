//
//  L1_20V.swift
//  SwiftAA
//
//  Created by Kihron on 2/25/24.
//

import SwiftUI

struct L1_20V: View {
    @Access(\.advancementManager) private var advancementManager
    @Access(\.metricManager) private var metricManager
    
    @State private var statisticIndicators: [StatisticIndicator] = [GodlyApple.shared, EnderPearls.shared, NetherWart.shared, GhastTears.shared, Pufferfish.shared, AzureBluet.shared, FermentedEye.shared, NetheriteUpgrade.shared, PotterySherds.shared]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                AdvPanelView(indicators: .constant(advancementManager.minimalisticAdvancements), columnCount: 5, isMinimal: true)
                    .frame(width: 370)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        AdvPanelView(indicators: metricManager.getSpecificStats(types: [.trident, .shells, .snifferEggs, .witherSkulls, .goldBlocks]), columnCount: 1, isStat: true)
                            .frame(width: 74)
                        
                        VStack(spacing: 0) {
                            InfoPanelView()
                                .frame(height: 341)
                            
                            StatisticPanelView(statistics: $statisticIndicators, rowCount: 5)
                                .frame(height: 90)
                        }
                        .frame(width: 236)
                    }
                    .frame(height: 431)
                    
                    HStack(spacing: 0) {
                        GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:husbandry/complete_catalogue"), rowCount: 6, goal: L10n.Goal.cats, isMinimal: true)
                            .frame(width: 155)
                        
                        GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:nether/explore_nether"), rowCount: 6, goal: L10n.Goal.nether, isMinimal: true)
                            .frame(width: 155)
                    }
                    .frame(height: 165)
                    
                    GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:husbandry/bred_all_animals"), rowCount: 8, goal: L10n.Goal.animalsBred, isMinimal: true)
                        .frame(height: 200)
                }
                .frame(width: 310)
            }
            .frame(height: 796)
            
            HStack(spacing: 0) {
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:adventure/adventuring_time"), rowCount: 14, goal: L10n.Goal.biomesVisited, isMinimal: true)
                    .frame(width: 534)
                
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:adventure/trim_with_all_exclusive_armor_patterns"), rowCount: 14, goal: L10n.Goal.trims, isMinimal: true, hidePercentage: true)
            }
            .frame(height: 310)
            
            HStack(spacing: 0) {
                GoalPanelView(advancement:  advancementManager.getGoalAdvancement(id: "minecraft:adventure/kill_all_mobs"), rowCount: 12, goal: L10n.Goal.monstersKilled, isMinimal: true)
                    .frame(width: 343)
                
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:husbandry/balanced_diet"), rowCount: 14, goal: L10n.Goal.foodsEaten, isMinimal: true)
                    .frame(width: 337)
            }
            .frame(height: 285)
        }
    }
}

#Preview {
    L1_20V()
}
