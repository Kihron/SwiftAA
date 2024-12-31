//
//  L1_16V.swift
//  SwiftAA
//
//  Created by Slackow on 10/8/23.
//

import SwiftUI

struct L1_16V: View {
    private var dataManager = DataManager.shared
    
    @State private var statusIndicators = Utilities.getSpecificStats(types: [.godApple, .trident, .shells, .ancientDebris, .beehives, .goldBlocks])
    
    @State private var statisticIndicators: [StatisticIndicator] = [EnderPearls.shared, NetherWart.shared, GhastTears.shared, Pufferfish.shared, AzureBluet.shared, FermentedEye.shared]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                AdvPanelView(indicators: .constant(dataManager.minimalisticAdvancements), columnCount: 5, isMinimal: true)
                    .frame(width: 370)
                
                AdvPanelView(indicators: $statusIndicators, columnCount: 1, isStat: true)
                    .frame(width: 74)
                
                VStack(spacing: 0) {
                    InfoPanelView()
                    
                    StatisticPanelView(statistics: $statisticIndicators, rowCount: 3)
                        .frame(height: 75)
                }
                .frame(width: 236)
            }
            .frame(height: 506)
            
            HStack(spacing:0) {
                GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/balanced_diet"), rowCount: 13, goal: L10n.Goal.foodsEaten, isMinimal: true)
                    .frame(width: 330)
                
                GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/bred_all_animals"), rowCount: 14, goal: L10n.Goal.animalsBred, isMinimal: true)
                    .frame(width: 186)
                
                VStack(spacing:0) {
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/complete_catalogue"), rowCount: 6, goal: L10n.Goal.cats, isMinimal: true)
                    
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:nether/explore_nether"), rowCount: 5, goal: L10n.Goal.nether, isMinimal: true)
                }
                .frame(width: 164)
            }
            .frame(height: 310)
            
            HStack(spacing: 0) {
                GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:adventure/adventuring_time"), rowCount: 14, goal: L10n.Goal.biomesVisited, isMinimal: true)
                    .frame(width: 358)
                GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:adventure/kill_all_mobs"), rowCount: 14, goal: L10n.Goal.monstersKilled, isMinimal: true)
                    .frame(width: 322)
            }
            .frame(width: 680, height: 310)
        }
    }
}

#Preview {
    L1_16M()
}
