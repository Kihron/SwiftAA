//
//  L1_19.swift
//  SwiftAA
//
//  Created by Kihron on 8/22/22.
//

import SwiftUI

struct L1_19: View {
    @ObservedObject var dataHandler: DataHandler
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            AdvPanelView(indicators: dataHandler.decode(file: "minecraft", start: "minecraft:story/mine_stone"), columnCount: 5)
                                .frame(width: 350)
                            AdvPanelView(indicators: dataHandler.decode(file: "nether"), columnCount: 8)
                                .frame(width: 540)
                            AdvPanelView(indicators: dataHandler.decode(file: "husbandry", start: "minecraft:husbandry/froglights"), columnCount: 1)
                                .frame(width: 74)
                            AdvPanelView(indicators: dataHandler.decode(file: "adventure", end: "minecraft:adventure/spyglass_at_dragon"), columnCount: 6)
                                .frame(width: 467)
                            AdvPanelView(indicators: Binding.constant(dataHandler.topStats), columnCount: 1, isStat: true)
                                .frame(width: 75)
                        }
                        
                        HStack(spacing: 0) {
                            AdvPanelView(indicators: dataHandler.decode(file: "end", start: "minecraft:end/kill_dragon"), columnCount: 4)
                                .frame(width: 276)
                            AdvPanelView(indicators: dataHandler.decode(file: "husbandry", end: "minecraft:husbandry/allay_deliver_cake_to_note_block"), columnCount: 10)
                                .frame(width: 688)
                            AdvPanelView(indicators: dataHandler.decode(file: "adventure", start: "minecraft:adventure/honey_block_slide"), columnCount: 6)
                                .frame(width: 467)
                            AdvPanelView(indicators: Binding.constant(dataHandler.bottomStats), columnCount: 1, isStat: true)
                                .frame(width: 75)
                        }
                    }
                    
                    InfoPanelView()
                        .frame(width: 196)
                }
                
                HStack(spacing: 0) {
                    GoalPanelView(advancement: dataHandler.decode(file: "adventure")[26].asAdvancement, rowCount: 16, goal: "goal-biomes-visited".localized)
                        .frame(width: 521)
                    GoalPanelView(advancement: dataHandler.decode(file: "adventure")[27].asAdvancement, rowCount: 16, goal: "goal-monsters-killed".localized)
                        .frame(width: 362)
                    GoalPanelView(advancement: dataHandler.decode(file: "husbandry")[15].asAdvancement, rowCount: 16, goal: "goal-foods-eaten".localized)
                        .frame(width: 355)
                    GoalPanelView(advancement: dataHandler.decode(file: "husbandry")[14].asAdvancement, rowCount: 16, goal: "goal-animals-bred".localized)
                        .frame(width: 193)
                    GoalPanelView(advancement: dataHandler.decode(file: "husbandry")[16].asAdvancement, rowCount: 16, goal: "goal-cats".localized)
                        .frame(width: 141)
                    GoalPanelView(advancement: dataHandler.decode(file: "nether")[9].asAdvancement, rowCount: 16, goal: "goal-nether".localized)
                        .frame(width: 130)
                }
                .frame(width: 1702, height: 323)
            }
        }
    }
}

struct L1_19_Previews: PreviewProvider {
    @StateObject static var settings = AppSettings()
    @ObservedObject static var dataHandler = DataHandler()
    
    static var previews: some View {
        L1_19(dataHandler: dataHandler)
            .frame(width: 1702, height: 754)
            .environmentObject(settings)
    }
}
