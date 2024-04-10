//
//  L1_19S.swift
//  SwiftAA
//
//  Created by Kihron on 3/19/24.
//

import SwiftUI

struct L1_19S: View {
    @State private var topStats = Utilities.getSpecificStats(types: [.godApple, .trident, .shells])
    @State private var bottomStats = Utilities.getSpecificStats(types: [.witherSkulls, .ancientDebris])
    
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
                                .frame(width: 540)
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "husbandry", start: "minecraft:husbandry/froglights"), columnCount: 1)
                                .frame(width: 74)
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "adventure", end: "minecraft:adventure/spyglass_at_dragon"), columnCount: 6)
                                .frame(width: 437)
                            AdvPanelView(indicators: $topStats, columnCount: 1, isStat: true)
                                .frame(width: 75)
                        }
                        
                        HStack(spacing: 0) {
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "end", start: "minecraft:end/kill_dragon"), columnCount: 4)
                                .frame(width: 276)
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "husbandry", end: "minecraft:husbandry/allay_deliver_cake_to_note_block"), columnCount: 10)
                                .frame(width: 688)
                            AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "adventure", start: "minecraft:adventure/honey_block_slide"), columnCount: 6)
                                .frame(width: 437)
                            AdvPanelView(indicators: $bottomStats, columnCount: 1, isStat: true)
                                .frame(width: 75)
                        }
                    }
                    
                    InfoPanelView()
                        .frame(width: 196, height: 431)
                }
                
                HStack(spacing: 0) {
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:adventure/adventuring_time"), rowCount: 16, goal: L10n.Goal.biomesVisited)
                        .frame(width: 521)
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:adventure/kill_all_mobs"), rowCount: 16, goal: L10n.Goal.monstersKilled)
                        .frame(width: 352)
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/balanced_diet"), rowCount: 16, goal: L10n.Goal.foodsEaten)
                        .frame(width: 325)
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/bred_all_animals"), rowCount: 16, goal: L10n.Goal.animalsBred)
                        .frame(width: 193)
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:husbandry/complete_catalogue"), rowCount: 16, goal: L10n.Goal.cats)
                        .frame(width: 141)
                    GoalPanelView(advancement: dataManager.getGoalAdvancement(id: "minecraft:nether/explore_nether"), rowCount: 16, goal: L10n.Goal.nether)
                        .frame(width: 140)
                }
                .frame(width: 1672, height: 333)
            }
        }
    }
}

#Preview {
    L1_19S()
}
