//
//  OverlayCompletedView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 8/16/22.
//

import SwiftUI

struct OverlayCompletedView: View {
    @ObservedObject var dataHandler: DataHandler
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        GeometryReader { screen in
            HStack(spacing: 0) {
                VStack {
                    ZStack {
                        RoundedCornersShape(radius: 5, corners: [.topLeft, .topRight])
                            .fill(Color("overlay_completed"))
                            .frame(width: screen.size.width / 1.7, height: 50)
                            .padding(.top)
                            .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 2.5) - 5) / 2)
                            .padding(.trailing, 5)
                        
                        Text("All \(dataHandler.map.values.compactMap({$0.count}).reduce(0, +)) Advancements Complete!")
                            .font(.custom("Minecraft-Regular", size: 24))
                            .padding(.top)
                            .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 2.5) - 5) / 2)
                    }
                    
                    ZStack {
                        RoundedCornersShape(radius: 5, corners: [.bottomLeft, .bottomRight])
                            .fill(Color("overlay_dark"))
                            .frame(width: screen.size.width / 1.7)
                            .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 2.5) - 5) / 2)
                            .padding(.top, -8)
                            .padding(.trailing, 5)
                        
                        VStack {
                            Text("\(settings.player!.name) has completed\nMinecraft: Java Edition (\(settings.gameVersion))\nAll Advancements")
                                .font(.custom("Minecraft-Regular", size: 24))
                                .multilineTextAlignment(.center)
                                .frame(width: screen.size.width / 1.7)
                                .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 2.5) - 5) / 2)
                            
                            Text("\(dataHandler.ticksToIGT(ticks: dataHandler.playTime))\nApproximate IGT")
                                .font(.custom("Minecraft-Regular", size: 24))
                                .multilineTextAlignment(.center)
                                .padding(.top)
                                .frame(width: screen.size.width / 1.7)
                                .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 2.5) - 5) / 2)
                        }
                    }
                    .padding(.bottom)
                    
                    Spacer()
                }
                
                VStack {
                    ZStack {
                        RoundedCornersShape(radius: 5, corners: [.topLeft, .topRight])
                            .fill(Color("overlay_completed"))
                            .frame(width: screen.size.width / 2.5, height: 50)
                            .padding(.top)
                        
                        
                        Text("overlay-complete-stats".localized)
                            .font(.custom("Minecraft-Regular", size: 24))
                            .padding(.top)
                    }
                    
                    ZStack {
                        RoundedCornersShape(radius: 5, corners: [.bottomLeft, .bottomRight])
                            .fill(Color("overlay_dark"))
                            .frame(width: screen.size.width / 2.5)
                            .padding(.top, -8)
                            .padding(.bottom)
                        
                        LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 32), spacing: 2, alignment: .leading), count: 3), spacing: 10) {
                            let array = getStatsArray()
                            ForEach(array.indices, id: \.self) { index in
                                array[index]
                            }
                        }
                        .padding(.top)
                    }
                    
                    Spacer()
                }

            }
        }
        .padding(.horizontal, 15)
        .background(settings.userOverlayColor)
    }
    
    func getStatsArray() -> [AnyView] {
        return [
            AnyView(StatsView(stat: Stat(id: "minecraft:aviate_one_cm", type: "minecraft:custom", factor: 100_000, icon: "rockets", secondaryIcon: "elytra", tooltip: "KM", flipped: true), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:bread", type: "minecraft:used", icon: "heal", secondaryIcon: "bread", tooltip: "Eaten"), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:enchant_item", type: "minecraft:custom", icon: "lapis_lazuli", secondaryIcon: "enchantment_table", tooltip: "Ench'ed"), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:ender_pearl", type: "minecraft:used", icon: "ender_pearl", secondaryIcon: "ender_pearl", tooltip: "Thrown", flipped: true), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:tnt", type: "minecraft:mined", factor: 9, icon: "tnt", secondaryIcon: "sandstone", tooltip: "Temples"), statsData: dataHandler.statsData)),
            
            AnyView(Spacer()),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:creeper", type: "minecraft:killed", icon: "kill_all_mobs", secondaryIcon: "creeper"), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:drowned", type: "minecraft:killed", icon: "kill_all_mobs", secondaryIcon: "drowned"), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:wither_skeleton", type: "minecraft:killed", icon: "kill_all_mobs", secondaryIcon: "wither_skeleton"), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:cod", type: "minecraft:killed", icon: "diamond_axe", secondaryIcon: "cod"), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:salmon", type: "minecraft:killed", icon: "diamond_axe", secondaryIcon: "salmon"), statsData: dataHandler.statsData)),
            
            AnyView(Spacer()),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:netherrack", type: "minecraft:mined", icon: "diamond_pickaxe", secondaryIcon: "netherrack"), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:gold_block", type: "minecraft:mined", icon: "diamond_pickaxe", secondaryIcon: "gold_block"), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:ender_chest", type: "minecraft:mined", icon: "diamond_pickaxe", secondaryIcon: "ender_chest"), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:lectern", type: "minecraft:mined", icon: "diamond_axe", secondaryIcon: "lectern"), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:sugar_cane", type: "minecraft:picked_up", icon: "diamond_axe", secondaryIcon: "sugarcane"), statsData: dataHandler.statsData))
        ]
    }
}

struct OverlayCompletedView_Previews: PreviewProvider {
    @ObservedObject static var dataHandler = DataHandler()
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        OverlayCompletedView(dataHandler: dataHandler)
            .frame(width: 820, height: 354)
            .environmentObject(settings)
    }
}
