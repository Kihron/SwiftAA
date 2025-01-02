//
//  L1_21M.swift
//  SwiftAA
//
//  Created by Slackow on 12/29/24.
//

import SwiftUI

struct L1_21M: View {
    @Access(\.advancementManager) private var advancementManager
    @Access(\.metricManager) private var metricManager

    @State private var statisticIndicators: [StatisticIndicator] = [GodlyApple.shared, EnderPearls.shared, NetherWart.shared, GhastTears.shared, Pufferfish.shared, AzureBluet.shared, FermentedEye.shared, NetheriteUpgrade.shared, PotterySherds.shared]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                AdvPanelView(indicators: .constant(advancementManager.minimalisticAdvancements), columnCount: 12, isMinimal: true)
                    .frame(width: 814)
                
                AdvPanelView(indicators: metricManager.getSpecificStats(types: [.trident, .snifferEggs, .shells, .goldBlocks, .witherSkulls, .beehives, .ancientDebris, .heavyCore]), columnCount: 2, isStat: true)
                    .frame(width: 148)
                
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:husbandry/balanced_diet"), rowCount: 18, goal: L10n.Goal.foodsEaten, isMinimal: true)
                    .frame(width: 330)
                
                InfoPanelView()
                    .frame(width: 196)
            }
            .frame(height: 438)
            
            HStack(spacing: 0) {
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:adventure/adventuring_time"), rowCount: 14, goal: L10n.Goal.biomesVisited, isMinimal: true)
                    .frame(width: 514)
                GoalPanelView(advancement:  advancementManager.getGoalAdvancement(id: "minecraft:adventure/kill_all_mobs"), rowCount: 14, goal: L10n.Goal.monstersKilled, isMinimal: true)
                    .frame(width: 335)
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:husbandry/bred_all_animals"), rowCount: 14, goal: L10n.Goal.animalsBred, isMinimal: true)
                    .frame(width: 180)
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:husbandry/complete_catalogue"), rowCount: 14, goal: "", isMinimal: true, hidePercentage: true)
                    .frame(width: 90)
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:husbandry/whole_pack"), rowCount: 14, goal: L10n.Goal.dogs, isMinimal: true, hidePercentage: true)
                    .frame(width: 90)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:adventure/trim_with_all_exclusive_armor_patterns"), rowCount: 8, goal: L10n.Goal.trims, isMinimal: true, hidePercentage: true)
                            .frame(width: 145)
                        
                        StatisticPanelView(statistics: $statisticIndicators, rowCount: 9)
                            .frame(width: 134)
                    }
                    .frame(height: 193)
                    
                    GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:nether/explore_nether"), rowCount: 3, goal: L10n.Goal.nether, isMinimal: true)
                        .frame(height: 117)
                }
                .frame(width: 279)
            }
            .frame(width: 1488, height: 310)
        }
    }
}

#Preview {
    L1_20M()
}
