//
//  OverlayViewModel.swift
//  SwiftAA
//
//  Created by Kihron on 1/10/23.
//

import SwiftUI

class MultiPageOverlayViewModel: ObservableObject {
    @ObservedObject var dataManager = DataManager.shared
    
    init() {
        
    }
    
    var totalAdvancements: Int {
        return dataManager.totalAdvancements
    }
    
    var completedAdvancements: Int {
        return dataManager.completedAdvancements
    }

    func getSection(_ section: Int, screen: GeometryProxy) -> [Advancement] {
        let values = dataManager.map.values.flatMap({$0}).filter({!$0.completed})
        
        let maxOnScreen = getMaxOnScreen(type: "indicator", width: screen.size.width)
        
        let sectionStart = section * maxOnScreen
        let sectionEnd = sectionStart + maxOnScreen
        
        return values.enumerated().filter { $0.offset >= sectionStart && $0.offset < sectionEnd }.map { $0.element }
    }
    
    func totalSections(screen: GeometryProxy) -> Int {
        (dataManager.map.values.flatMap({ $0 }).filter({ !$0.completed }).count / Int((floor(screen.size.width / 74))) + 1) / 2
    }
    
    func getCriteriaSection(_ section: Int, screen: GeometryProxy) -> [Criterion] {
        let values = dataManager.map.values.flatMap({$0}).filter({!$0.completed && !$0.criteria.isEmpty}).flatMap({$0.criteria}).filter{!$0.completed}
        
        let maxOnScreen = getMaxOnScreen(type: "criteria", width: screen.size.width)
        
        let sectionStart = section * maxOnScreen
        let sectionEnd = sectionStart + maxOnScreen
        
        return values.enumerated().filter { $0.offset >= sectionStart && $0.offset < sectionEnd }.map { $0.element }
    }
    
    func totalCriteriaSections(screen: GeometryProxy) -> Int {
        let count = dataManager.map.values.flatMap({$0}).filter({!$0.completed && !$0.criteria.isEmpty}).flatMap({$0.criteria}).filter{!$0.completed}.count
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
            AnyView(StatsView(stat: Statistic(id: "minecraft:aviate_one_cm", type: "minecraft:custom", factor: 100_000, icon: "rockets", secondaryIcon: "elytra", tooltip: L10n.Overlay.Complete.Stat.elytra, flipped: true), statsData: dataManager.statsData)),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:bread", type: "minecraft:used", icon: "heal", secondaryIcon: "bread", tooltip: L10n.Overlay.Complete.Stat.bread), statsData: dataManager.statsData)),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:enchant_item", type: "minecraft:custom", icon: "lapis_lazuli", secondaryIcon: "enchantment_table", tooltip: L10n.Overlay.Complete.Stat.enchant), statsData: dataManager.statsData)),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:ender_pearl", type: "minecraft:used", icon: "ender_pearl", secondaryIcon: "ender_pearl", tooltip: L10n.Overlay.Complete.Stat.pearl, flipped: true), statsData: dataManager.statsData)),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:tnt", type: "minecraft:mined", factor: 9, icon: "tnt", secondaryIcon: "sandstone", tooltip: L10n.Overlay.Complete.Stat.temples), statsData: dataManager.statsData)),
            
            AnyView(Spacer()),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:creeper", type: "minecraft:killed", icon: "kill_all_mobs", secondaryIcon: "creeper"), statsData: dataManager.statsData)),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:drowned", type: "minecraft:killed", icon: "kill_all_mobs", secondaryIcon: "drowned"), statsData: dataManager.statsData)),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:wither_skeleton", type: "minecraft:killed", icon: "kill_all_mobs", secondaryIcon: "wither_skeleton"), statsData: dataManager.statsData)),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:cod", type: "minecraft:killed", icon: "diamond_axe", secondaryIcon: "cod"), statsData: dataManager.statsData)),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:salmon", type: "minecraft:killed", icon: "diamond_axe", secondaryIcon: "salmon"), statsData: dataManager.statsData)),
            
            AnyView(Spacer()),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:netherrack", type: "minecraft:mined", icon: "diamond_pickaxe", secondaryIcon: "netherrack"), statsData: dataManager.statsData)),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:gold_block", type: "minecraft:mined", icon: "diamond_pickaxe", secondaryIcon: "gold_block"), statsData: dataManager.statsData)),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:ender_chest", type: "minecraft:mined", icon: "diamond_pickaxe", secondaryIcon: "ender_chest"), statsData: dataManager.statsData)),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:lectern", type: "minecraft:mined", icon: "diamond_axe", secondaryIcon: "lectern"), statsData: dataManager.statsData)),
            
            AnyView(StatsView(stat: Statistic(id: "minecraft:sugar_cane", type: "minecraft:picked_up", icon: "diamond_axe", secondaryIcon: "sugarcane"), statsData: dataManager.statsData))
        ]
    }
}