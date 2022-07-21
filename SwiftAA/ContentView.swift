//
//  ContentView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/20/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var dataHandler = DataHandler()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    AdvGroupView(advancements: dataHandler.decode(file: "minecraft", start: "minecraft:story/mine_stone"), columnCount: 5)
                    AdvGroupView(advancements: dataHandler.decode(file: "end", start: "minecraft:end/kill_dragon"), columnCount: 5)
                }
                .frame(width: 350)
                
                VStack(spacing: 0) {
                    AdvGroupView(advancements: dataHandler.decode(file: "nether"), columnCount: 8)
                    AdvGroupView(advancements: dataHandler.decode(file: "husbandry"), columnCount: 8)
                }
                .frame(width: 540)
                
                VStack(spacing: 0) {
                    AdvGroupView(advancements: dataHandler.decode(file: "adventure", end: "minecraft:adventure/sniper_duel"), columnCount: 4)
                    AdvGroupView(advancements: dataHandler.decode(file: "adventure", start: "minecraft:adventure/voluntary_exile"), columnCount: 4)
                }
                .frame(width: 270)
            
                PotionPanelView()
            }
            
            HStack(spacing: 0) {
                GoalView(advancement: dataHandler.decode(file: "adventure")[18], rowCount: 16)
                    .frame(width: 350)
                GoalView(advancement: dataHandler.decode(file: "adventure")[19], rowCount: 16)
                    .frame(width: 300)
                GoalView(advancement: dataHandler.decode(file: "husbandry")[10], rowCount: 16)
                    .frame(width: 330)
                GoalView(advancement: dataHandler.decode(file: "husbandry")[9], rowCount: 16)
                    .frame(width: 168)
                GoalView(advancement: dataHandler.decode(file: "husbandry")[11], rowCount: 16)
                    .frame(width: 108)
                GoalView(advancement: dataHandler.decode(file: "nether")[14], rowCount: 16)
                    .frame(width: 100)
            }
            .frame(width: 1356, height: 344)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 1356, height: 775)
    }
}
