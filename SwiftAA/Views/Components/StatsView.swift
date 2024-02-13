//
//  StatsView.swift
//  SwiftAA
//
//  Created by Kihron on 8/18/22.
//

import SwiftUI

struct StatsView: View {
    @ObservedObject private var dataManager = DataManager.shared
    @State var stat: Statistic
    
    private var statValue: String {
        let value = Double(dataManager.statsData[stat.type]?[stat.id] ?? 0)
        if stat.factor > 1 {
            return String(format: stat.factor >= 10 ? "%.1f" : "%.0f", value / Double(stat.factor))
        } else {
            return value >= 1000 ? String(format: "%.1fk", value / 1000) : "\(Int(value))"
        }
    }
    
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
            .padding(.trailing, 5)
        
            
            Text(statValue)
                .minecraftFont(size: 20)
            
            if (!stat.tooltip.isEmpty) {
                Text(stat.tooltip.localized)
                    .minecraftFont(size: 12)
                
                Spacer()
            }
        }
        .frame(maxWidth: 160)
        .padding(.trailing, -3)
    }
    
    func getStatValue() -> Int {
        dataManager.statsData[stat.type]?[stat.id] ?? 0
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(stat: Statistic(id: "minecraft:stat", type: "", factor: 100_000, icon: "rockets", secondaryIcon: "elytra", tooltip: "KM"))
            .padding()
    }
}
