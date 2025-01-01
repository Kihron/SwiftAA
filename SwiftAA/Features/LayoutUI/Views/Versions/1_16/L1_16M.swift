//
//  L1_16M.swift
//  SwiftAA
//
//  Created by Kihron on 9/27/23.
//

import SwiftUI

struct L1_16M: View {
    @Access(\.advancementManager) private var advancementManager

    @State private var statusIndicators = Utilities.getSpecificStats(types: [.godApple, .trident, .shells, .witherSkulls, .ancientDebris, .beehives, .goldBlocks])
    @State private var statistics: [StatisticIndicator] = [EnderPearls.shared, NetherWart.shared, GhastTears.shared, Pufferfish.shared, AzureBluet.shared, FermentedEye.shared]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                AdvPanelView(indicators: .constant(advancementManager.minimalisticAdvancements), columnCount: 7, isMinimal: true)
                    .frame(width: 518)
                
                AdvPanelView(indicators: $statusIndicators, columnCount: 2, isStat: true)
                    .frame(width: 148)
                
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:husbandry/balanced_diet"), rowCount: 15, goal: L10n.Goal.foodsEaten, isMinimal: true)
                    .frame(width: 330)
                
                InfoPanelView()
                    .frame(width: 196)
            }
            .frame(height: 364)
            
            HStack(spacing: 0) {
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:adventure/adventuring_time"), rowCount: 14, goal: L10n.Goal.biomesVisited, isMinimal: true)
                    .frame(width: 368)
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:adventure/kill_all_mobs"), rowCount: 14, goal: L10n.Goal.monstersKilled, isMinimal: true)
                    .frame(width: 330)
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:husbandry/bred_all_animals"), rowCount: 14, goal: L10n.Goal.animalsBred, isMinimal: true)
                    .frame(width: 186)
                GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:husbandry/complete_catalogue"), rowCount: 14, goal: L10n.Goal.cats, isMinimal: true)
                    .frame(width: 159)
                
                VStack(spacing: 0) {
                    StatisticPanelView(statistics: $statistics, rowCount: 6)
                        .frame(height: 125)
                    
                    GoalPanelView(advancement: advancementManager.getGoalAdvancement(id: "minecraft:nether/explore_nether"), rowCount: 7, goal: L10n.Goal.nether, isMinimal: true)
                        .frame(height: 185)
                }
                .frame(width: 149)
            }
            .frame(width: 1192, height: 310)
        }
    }
}

#Preview {
    L1_16M()
}
