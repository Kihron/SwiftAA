//
//  L1_16S.swift
//  SwiftAA
//
//  Created by Kihron on 9/27/23.
//

import SwiftUI

struct L1_16S: View {
    @ObservedObject private var dataManager = DataManager.shared
    @State private var topStats = Array(DataManager.shared.stats.prefix(3))
    @State private var bottomStats = Array(DataManager.shared.stats.dropFirst(3).dropLast(2))
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    AdvPanelView(indicators: dataManager.decode(file: "minecraft", start: "minecraft:story/mine_stone"), columnCount: 5)
                    AdvPanelView(indicators: dataManager.decode(file: "end", start: "minecraft:end/kill_dragon"), columnCount: 5)
                }
                .frame(width: 350)
                
                VStack(spacing: 0) {
                    AdvPanelView(indicators: dataManager.decode(file: "nether"), columnCount: 8)
                    AdvPanelView(indicators: dataManager.decode(file: "husbandry"), columnCount: 8)
                }
                .frame(width: 540)
                
                VStack(spacing: 0) {
                    AdvPanelView(indicators: dataManager.decode(file: "adventure", end: "minecraft:adventure/sniper_duel"), columnCount: 4)
                    AdvPanelView(indicators: dataManager.decode(file: "adventure", start: "minecraft:adventure/voluntary_exile"), columnCount: 4)
                }
                .frame(width: 270)
                
                VStack(spacing: 0) {
                    AdvPanelView(indicators: $topStats, columnCount: 1, isStat: true)
                    AdvPanelView(indicators: $bottomStats, columnCount: 1, isStat: true)
                }
                .frame(width: 75)
                
                InfoPanelView()
                    .frame(width: 196, height: 431)
                
            }
            
            HStack(spacing: 0) {
                GoalPanelView(advancement: dataManager.decode(file: "adventure")[18].asAdvancement, rowCount: 16, goal: L10n.Goal.Biomes.visited)
                    .frame(width: 350)
                GoalPanelView(advancement: dataManager.decode(file: "adventure")[19].asAdvancement, rowCount: 16, goal: L10n.Goal.Monsters.killed)
                    .frame(width: 312)
                GoalPanelView(advancement: dataManager.decode(file: "husbandry")[10].asAdvancement, rowCount: 16, goal: L10n.Goal.Foods.eaten)
                    .frame(width: 330)
                GoalPanelView(advancement: dataManager.decode(file: "husbandry")[9].asAdvancement, rowCount: 16, goal: L10n.Goal.Animals.bred)
                    .frame(width: 168)
                GoalPanelView(advancement: dataManager.decode(file: "husbandry")[11].asAdvancement, rowCount: 16, goal: L10n.Goal.cats)
                    .frame(width: 141)
                GoalPanelView(advancement: dataManager.decode(file: "nether")[9].asAdvancement, rowCount: 16, goal: L10n.Goal.nether)
                    .frame(width: 130)
            }
            .frame(width: 1431, height: 333)
        }
    }
}

#Preview {
    L1_16S()
}
