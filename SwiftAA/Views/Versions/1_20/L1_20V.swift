//
//  L1_20V.swift
//  SwiftAA
//
//  Created by Kihron on 2/25/24.
//

import SwiftUI

struct L1_20V: View {
    @ObservedObject private var dataManager = DataManager.shared
    
    @State private var statusIndicators = Utilities.getSpecificStats(types: [.trident, .shells, .snifferEggs, .witherSkulls, .goldBlocks])
    
    @State private var statisticIndicators: [StatisticIndicator] = [GodlyApple.shared, EnderPearls.shared, NetherWart.shared, GhastTears.shared, Pufferfish.shared, AzureBluet.shared, FermentedEye.shared, NetheriteUpgrade.shared, PotterySherds.shared]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                AdvPanelView(indicators: dataManager.getMinimalisticAdvancements(), columnCount: 5, isMinimal: true)
                    .frame(width: 370)
                
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
                        GoalPanelView(advancement: dataManager.decode(file: "husbandry")[21].asAdvancement, rowCount: 6, goal: L10n.Goal.cats, isMinimal: true)
                            .frame(width: 155)
                        
                        GoalPanelView(advancement: dataManager.decode(file: "nether")[9].asAdvancement, rowCount: 6, goal: L10n.Goal.nether, isMinimal: true)
                            .frame(width: 155)
                    }
                    .frame(height: 165)
                    
                    GoalPanelView(advancement: dataManager.decode(file: "husbandry")[19].asAdvancement, rowCount: 8, goal: L10n.Goal.animalsBred, isMinimal: true)
                        .frame(height: 200)
                }
                .frame(width: 310)
            }
            .frame(height: 796)
            
            HStack(spacing: 0) {
                GoalPanelView(advancement: dataManager.decode(file: "adventure")[33].asAdvancement, rowCount: 14, goal: L10n.Goal.biomesVisited, isMinimal: true)
                    .frame(width: 534)
                
                GoalPanelView(advancement: dataManager.decode(file: "adventure")[18].asAdvancement, rowCount: 14, goal: L10n.Goal.trims, isMinimal: true, hidePercentage: true)
            }
            .frame(height: 310)
            
            HStack(spacing: 0) {
                GoalPanelView(advancement: dataManager.decode(file: "adventure")[34].asAdvancement, rowCount: 12, goal: L10n.Goal.monstersKilled, isMinimal: true)
                    .frame(width: 343)
                
                GoalPanelView(advancement: dataManager.decode(file: "husbandry")[20].asAdvancement, rowCount: 14, goal: L10n.Goal.foodsEaten, isMinimal: true)
                    .frame(width: 337)
            }
            .frame(height: 285)
        }
    }
}

#Preview {
    L1_20V()
}
