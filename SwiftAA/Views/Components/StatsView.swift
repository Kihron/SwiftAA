//
//  StatsView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 8/18/22.
//

import SwiftUI

struct StatsView: View {
    @State var stat: Stat
    @State var statsData: [String:[String:Int]]
    
    var body: some View {
        HStack {
            ZStack {
                Image(stat.icon)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .offset(x: -12)
                    .zIndex(stat.flipped ? 0 : 1)
                
                Image(stat.secondaryIcon)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .offset(x: 5)
                    .padding(.trailing, stat.tooltip.isEmpty ? 10 : 0)
            }
            
            if (!stat.tooltip.isEmpty) {
                Spacer()
            }
            
            Text("\(getStatValue() / stat.factor)")
                .font(.custom("Minecraft-Regular", size: 24))
            
            if (!stat.tooltip.isEmpty) {
                Spacer()
                
                Text(stat.tooltip)
                    .font(.custom("Minecraft-Regular", size: 14))
            }
        }
        .frame(maxWidth: 160)
    }
    
    func getStatValue() -> Int {
        statsData[stat.type]?[stat.id] ?? 0
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(stat: Stat(id: "minecraft:stat", type: "", factor: 10000, icon: "rockets", secondaryIcon: "elytra", tooltip: ""), statsData: [String:[String:Int]]())
            .padding()
    }
}
