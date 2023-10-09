//
//  L1_16M.swift
//  SwiftAA
//
//  Created by Kihron on 9/27/23.
//

import SwiftUI

struct L1_16M: View {
    @ObservedObject private var dataManager = DataManager.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    AdvPanelView(indicators: dataManager.getMinimalisticAdvancements(), columnCount: 7, isMinimal: true)
                }
                .frame(width: 518)
                
                VStack {
                    AdvPanelView(indicators: $dataManager.stats, columnCount: 2, isStat: true)
                }
                .frame(width: 148)
                
                GoalPanelView(advancement: dataManager.decode(file: "husbandry")[10].asAdvancement, rowCount: 16, goal: L10n.Goal.Foods.eaten, isMinimal: true)
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
                GoalPanelView(advancement: dataManager.decode(file: "nether")[9].asAdvancement, rowCount: 14, goal: L10n.Goal.nether, isMinimal: true)
                    .frame(width: 149)
            }
            .frame(width: 1192, height: 310)
        }
    }
}

#Preview {
    L1_16M()
}
