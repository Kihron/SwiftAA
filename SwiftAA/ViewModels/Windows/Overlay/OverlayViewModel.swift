//
//  OverlayViewModel.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 1/10/23.
//

import SwiftUI

class OverlayViewModel: ObservableObject {
    @ObservedObject var dataHandler: DataHandler
    
    init(dataHandler: DataHandler) {
        self._dataHandler = ObservedObject(wrappedValue: dataHandler)
    }
    
    var totalAdvancements: Int {
        return dataHandler.totalAdvancements
    }
    
    var completedAdvancements: Int {
        return dataHandler.completedAdvancements
    }

    func getSection(_ section: Int, screen: GeometryProxy) -> [Advancement] {
        let values = dataHandler.map.values.flatMap({$0}).filter({!$0.completed})
        
        let maxOnScreen = getMaxOnScreen(type: "indicator", width: screen.size.width)
        
        let sectionStart = section * maxOnScreen
        let sectionEnd = sectionStart + maxOnScreen
        
        return values.enumerated().filter { $0.offset >= sectionStart && $0.offset < sectionEnd }.map { $0.element }
    }
    
    func totalSections(screen: GeometryProxy) -> Int {
        (dataHandler.map.values.flatMap({ $0 }).filter({ !$0.completed }).count / Int((floor(screen.size.width / 74))) + 1) / 2
    }
    
    func getCriteriaSection(_ section: Int, screen: GeometryProxy) -> [Criterion] {
        let values = dataHandler.map.values.flatMap({$0}).filter({!$0.completed && !$0.criteria.isEmpty}).flatMap({$0.criteria}).filter{!$0.completed}
        
        let maxOnScreen = getMaxOnScreen(type: "criteria", width: screen.size.width)
        
        let sectionStart = section * maxOnScreen
        let sectionEnd = sectionStart + maxOnScreen
        
        return values.enumerated().filter { $0.offset >= sectionStart && $0.offset < sectionEnd }.map { $0.element }
    }
    
    func totalCriteriaSections(screen: GeometryProxy) -> Int {
        let count = dataHandler.map.values.flatMap({$0}).filter({!$0.completed && !$0.criteria.isEmpty}).flatMap({$0.criteria}).filter{!$0.completed}.count
        let maxOnScreen = getMaxOnScreen(type: "criteria", width: screen.size.width)
        let pages = max(1, (count - 0) / maxOnScreen + 1)
        return pages
    }
    
    func getMaxOnScreen(type: String, width: CGFloat) -> Int {
        switch type {
            case "indicator" : return Int(floor(width / 74)) * 2
            case "criteria" : return Int(floor((width - 40) / 26)) * 2
            default : return 0
        }
    }
    
    func getStatsArray() -> [AnyView] {
        return [
            AnyView(StatsView(stat: Stat(id: "minecraft:aviate_one_cm", type: "minecraft:custom", factor: 100_000, icon: "rockets", secondaryIcon: "elytra", tooltip: "overlay-complete-stat-elytra", flipped: true), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:bread", type: "minecraft:used", icon: "heal", secondaryIcon: "bread", tooltip: "overlay-complete-stat-bread"), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:enchant_item", type: "minecraft:custom", icon: "lapis_lazuli", secondaryIcon: "enchantment_table", tooltip: "overlay-complete-stat-enchant"), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:ender_pearl", type: "minecraft:used", icon: "ender_pearl", secondaryIcon: "ender_pearl", tooltip: "overlay-complete-stat-pearl", flipped: true), statsData: dataHandler.statsData)),
            
            AnyView(StatsView(stat: Stat(id: "minecraft:tnt", type: "minecraft:mined", factor: 9, icon: "tnt", secondaryIcon: "sandstone", tooltip: "overlay-complete-stat-temples"), statsData: dataHandler.statsData)),
            
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
