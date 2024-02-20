//
//  L1_19.swift
//  SwiftAA
//
//  Created by Kihron on 8/22/22.
//

import SwiftUI

struct L1_19: View {
    @ObservedObject private var dataManager = DataManager.shared
    
    @State private var topStats = Utilities.getSpecificStats(types: [.godApple, .trident, .shells])
    @State private var bottomStats = Utilities.getSpecificStats(types: [.witherSkulls, .ancientDebris])
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            AdvPanelView(indicators: dataManager.decode(file: "minecraft", start: "minecraft:story/mine_stone"), columnCount: 5)
                                .frame(width: 350)
                            AdvPanelView(indicators: dataManager.decode(file: "nether"), columnCount: 8)
                                .frame(width: 540)
                            AdvPanelView(indicators: dataManager.decode(file: "husbandry", start: "minecraft:husbandry/froglights"), columnCount: 1)
                                .frame(width: 74)
                            AdvPanelView(indicators: dataManager.decode(file: "adventure", end: "minecraft:adventure/spyglass_at_dragon"), columnCount: 6)
                                .frame(width: 437)
                            AdvPanelView(indicators: $topStats, columnCount: 1, isStat: true)
                                .frame(width: 75)
                        }
                        
                        HStack(spacing: 0) {
                            AdvPanelView(indicators: dataManager.decode(file: "end", start: "minecraft:end/kill_dragon"), columnCount: 4)
                                .frame(width: 276)
                            AdvPanelView(indicators: dataManager.decode(file: "husbandry", end: "minecraft:husbandry/allay_deliver_cake_to_note_block"), columnCount: 10)
                                .frame(width: 688)
                            AdvPanelView(indicators: dataManager.decode(file: "adventure", start: "minecraft:adventure/honey_block_slide"), columnCount: 6)
                                .frame(width: 437)
                            AdvPanelView(indicators: $bottomStats, columnCount: 1, isStat: true)
                                .frame(width: 75)
                        }
                    }
                    
                    InfoPanelView()
                        .frame(width: 196, height: 431)
                }
                
                HStack(spacing: 0) {
                    GoalPanelView(advancement: dataManager.decode(file: "adventure")[28].asAdvancement, rowCount: 16, goal: L10n.Goal.Biomes.visited)
                        .frame(width: 521)
                    GoalPanelView(advancement: dataManager.decode(file: "adventure")[29].asAdvancement, rowCount: 16, goal: L10n.Goal.Monsters.killed)
                        .frame(width: 352)
                    GoalPanelView(advancement: dataManager.decode(file: "husbandry")[15].asAdvancement, rowCount: 16, goal: L10n.Goal.Foods.eaten)
                        .frame(width: 325)
                    GoalPanelView(advancement: dataManager.decode(file: "husbandry")[14].asAdvancement, rowCount: 16, goal: L10n.Goal.Animals.bred)
                        .frame(width: 193)
                    GoalPanelView(advancement: dataManager.decode(file: "husbandry")[16].asAdvancement, rowCount: 16, goal: L10n.Goal.cats)
                        .frame(width: 141)
                    GoalPanelView(advancement: dataManager.decode(file: "nether")[9].asAdvancement, rowCount: 16, goal: L10n.Goal.nether)
                        .frame(width: 140)
                }
                .frame(width: 1672, height: 333)
            }
        }
    }
}

struct L1_19_Previews: PreviewProvider {
    static var previews: some View {
        L1_19()
            .frame(width: 1702, height: 754)
    }
}
