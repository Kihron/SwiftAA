//
//  L1_20V.swift
//  SwiftAA
//
//  Created by Kihron on 2/25/24.
//

import SwiftUI

struct L1_21V: View {
    private var dataManager = DataManager.shared
    
    @State private var statusIndicators = Utilities.getSpecificStats(types: [.trident, .shells, .snifferEggs, .witherSkulls, .goldBlocks])
    
    @State private var statisticIndicators: [StatisticIndicator] = [GodlyApple.shared, HeavilyCore.shared, EnderPearls.shared, NetherWart.shared, GhastTears.shared, Pufferfish.shared, AzureBluet.shared, FermentedEye.shared, NetheriteUpgrade.shared, PotterySherds.shared]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                AdvPanelView(indicators: .constant(dataManager.minimalisticAdvancements), columnCount: 6, isMinimal: true)
                    .frame(width: 400)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        AdvPanelView(indicators: $statusIndicators, columnCount: 1, isStat: true)
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
                        GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/complete_catalogue"), rowCount: 7, goal: L10n.Goal.cats, isMinimal: true)
                            .frame(width: 155)
                        
                        GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/whole_pack"), rowCount: 7, goal: L10n.Goal.dogs, isMinimal: true)
                            .frame(width: 155)
                    }
                    .frame(height: 185)
                    
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/bred_all_animals"), rowCount: 7, goal: L10n.Goal.animalsBred, isMinimal: true)
                        .frame(height: 180)
                }
                .frame(width: 310)
            }
            .frame(height: 796)
            
            HStack(spacing: 0) {
                GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:adventure/adventuring_time"), rowCount: 14, goal: L10n.Goal.biomesVisited, isMinimal: true)
                    .frame(width: 514)
                VStack(spacing: 0) {
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:adventure/trim_with_all_exclusive_armor_patterns"), rowCount: 4, goal: L10n.Goal.trims, isMinimal: true)
                        .frame(height: 140)
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:nether/explore_nether"), rowCount: 6, goal: L10n.Goal.nether, isMinimal: true)
                }
                .frame(width: 196)
            }
            .frame(height: 310)
            
            HStack(spacing: 0) {
                GoalPanelView(advancement:  dataManager.getGoalAdvancement(id: "minecraft:adventure/kill_all_mobs"), rowCount: 12, goal: L10n.Goal.monstersKilled, isMinimal: true)
                
                GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/balanced_diet"), rowCount: 14, goal: L10n.Goal.foodsEaten, isMinimal: true)
            }
            .frame(height: 285)
        }
    }
}

#Preview {
    L1_20V()
}
