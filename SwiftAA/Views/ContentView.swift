//
//  ContentView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/20/22.
//

import SwiftUI
import Cocoa

struct ContentView: View {
    @ObservedObject var dataHandler: DataHandler
    @State var refresh: Bool = false
    @Binding var changed: Bool
    
    var body: some View {
        ScrollView(.vertical) {
            ScrollView(.horizontal) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            AdvPanelView(indicators: dataHandler.decode(file: "minecraft", start: "minecraft:story/mine_stone"), columnCount: 5)
                            AdvPanelView(indicators: dataHandler.decode(file: "end", start: "minecraft:end/kill_dragon"), columnCount: 5)
                        }
                        .frame(width: 350)
                        
                        VStack(spacing: 0) {
                            AdvPanelView(indicators: dataHandler.decode(file: "nether"), columnCount: 8)
                            AdvPanelView(indicators: dataHandler.decode(file: "husbandry"), columnCount: 8)
                        }
                        .frame(width: 540)
                        
                        VStack(spacing: 0) {
                            AdvPanelView(indicators: dataHandler.decode(file: "adventure", end: "minecraft:adventure/sniper_duel"), columnCount: 4)
                            AdvPanelView(indicators: dataHandler.decode(file: "adventure", start: "minecraft:adventure/voluntary_exile"), columnCount: 4)
                        }
                        .frame(width: 270)
                        
                        VStack(spacing: 0) {
                            AdvPanelView(indicators: Binding.constant(dataHandler.topStats), columnCount: 1, isStat: true)
                            AdvPanelView(indicators: Binding.constant(dataHandler.bottomStats), columnCount: 1, isStat: true)
                        }
                        .frame(width: 75)
                        
                        InfoPanelView()
                            .frame(width: 196)
                    }
                    
                    HStack(spacing: 0) {
                        GoalPanelView(advancement: dataHandler.decode(file: "adventure")[18].asAdvancement, rowCount: 16, goal: "goal-biomes-visited".localized)
                            .frame(width: 350)
                        GoalPanelView(advancement: dataHandler.decode(file: "adventure")[19].asAdvancement, rowCount: 16, goal: "goal-monsters-killed".localized)
                            .frame(width: 312)
                        GoalPanelView(advancement: dataHandler.decode(file: "husbandry")[10].asAdvancement, rowCount: 16, goal: "goal-foods-eaten".localized)
                            .frame(width: 330)
                        GoalPanelView(advancement: dataHandler.decode(file: "husbandry")[9].asAdvancement, rowCount: 16, goal: "goal-animals-bred".localized)
                            .frame(width: 168)
                        GoalPanelView(advancement: dataHandler.decode(file: "husbandry")[11].asAdvancement, rowCount: 16, goal: "goal-cats".localized)
                            .frame(width: 141)
                        GoalPanelView(advancement: dataHandler.decode(file: "nether")[9].asAdvancement, rowCount: 16, goal: "goal-nether".localized)
                            .frame(width: 130)
                    }
                    .frame(width: 1431, height: 323)
                    
                    if (refresh && !refresh) {
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
                if (changed) {
                    withAnimation {
                        refresh.toggle()
                        changed = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @ObservedObject static var dataHandler = DataHandler()
    
    static var previews: some View {
        ContentView(dataHandler: dataHandler, changed: .constant(false))
            .frame(width: 1356, height: 775)
    }
}