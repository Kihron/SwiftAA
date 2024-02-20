//
//  StatsView.swift
//  SwiftAA
//
//  Created by Kihron on 8/18/22.
//

import SwiftUI

struct FinalStatsView: View {
    @ObservedObject private var progressManager = ProgressManager.shared
    @State var statistic: FinalStatistic
    
    var body: some View {
        HStack {
            ZStack {
                Image(statistic.icon)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .offset(x: -12)
                    .zIndex(statistic.flipped ? 0 : 1)
                
                Image(statistic.secondaryIcon)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .offset(x: 5)
                    .padding(.trailing, statistic.tooltip.isEmpty ? 10 : 0)
            }
            .padding(.trailing, 5)
        
            Text(statistic.getValue(progress: progressManager))
                .minecraftFont(size: 20)
            
            if (!statistic.tooltip.isEmpty) {
                Text(statistic.tooltip.localized)
                    .minecraftFont(size: 12)
                
                Spacer()
            }
        }
        .frame(maxWidth: 160)
        .padding(.trailing, -3)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        FinalStatsView(statistic: FinalStatistic(id: "minecraft:stat", type: "", factor: 100_000, icon: "rockets", secondaryIcon: "elytra", tooltip: "KM"))
            .padding()
    }
}
