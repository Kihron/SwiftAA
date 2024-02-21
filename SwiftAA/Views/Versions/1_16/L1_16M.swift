//
//  L1_16M.swift
//  SwiftAA
//
//  Created by Kihron on 9/27/23.
//

import SwiftUI

struct L1_16M: View {
    @ObservedObject private var dataManager = DataManager.shared
    
    @State private var statusIndicators = Utilities.getSpecificStats(types: [.godApple, .trident, .shells, .witherSkulls, .ancientDebris, .beehives, .goldBlocks])
    
    @State private var statistics: [StatisticIndicator] = [EnderPearls.shared, NetherWart.shared, GhastTears.shared, Pufferfish.shared, AzureBluet.shared, FermentedEye.shared]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    AdvPanelView(indicators: dataManager.getMinimalisticAdvancements(), columnCount: 7, isMinimal: true)
                }
                .frame(width: 518)
                
                VStack {
                    AdvPanelView(indicators: $statusIndicators, columnCount: 2, isStat: true)
                }
                .frame(width: 148)
                
                GoalPanelView(advancement: dataManager.decode(file: "husbandry")[10].asAdvancement, rowCount: 15, goal: L10n.Goal.Foods.eaten, isMinimal: true)
                .frame(width: 330)
                
                InfoPanelView()
                    .frame(width: 196)
            }
            .frame(height: 364)
            
            HStack(spacing: 0) {
                GoalPanelView(advancement: dataManager.decode(file: "adventure")[18].asAdvancement, rowCount: 14, goal: L10n.Goal.Biomes.visited, isMinimal: true)
                    .frame(width: 368)
                GoalPanelView(advancement: dataManager.decode(file: "adventure")[19].asAdvancement, rowCount: 14, goal: L10n.Goal.Monsters.killed, isMinimal: true)
                    .frame(width: 330)
                GoalPanelView(advancement: dataManager.decode(file: "husbandry")[9].asAdvancement, rowCount: 14, goal: L10n.Goal.Animals.bred, isMinimal: true)
                    .frame(width: 186)
                GoalPanelView(advancement: dataManager.decode(file: "husbandry")[11].asAdvancement, rowCount: 14, goal: L10n.Goal.cats, isMinimal: true)
                    .frame(width: 159)
                
                VStack(spacing: 0) {
                    StatisticPanelView(statistics: $statistics, rowCount: 6)
                        .frame(height: 125)
                    
                    GoalPanelView(advancement: dataManager.decode(file: "nether")[9].asAdvancement, rowCount: 7, goal: L10n.Goal.nether, isMinimal: true)
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
