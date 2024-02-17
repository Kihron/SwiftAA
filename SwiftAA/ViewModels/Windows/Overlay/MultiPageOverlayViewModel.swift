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
        return dataManager.allAdvancements.count
    }
    
    var completedAdvancements: Int {
        return dataManager.completedAdvancements.count
    }

    func getSection(_ section: Int, screen: GeometryProxy) -> [Advancement] {
        let values = dataManager.incompleteAdvancements
        
        let maxOnScreen = getMaxOnScreen(type: "indicator", width: screen.size.width)
        
        let sectionStart = section * maxOnScreen
        let sectionEnd = sectionStart + maxOnScreen
        
        return values.enumerated().filter { $0.offset >= sectionStart && $0.offset < sectionEnd }.map { $0.element }
    }
    
    func totalSections(screen: GeometryProxy) -> Int {
        (dataManager.incompleteAdvancements.count / Int((floor(screen.size.width / 74))) + 1) / 2
    }
    
    func getCriteriaSection(_ section: Int, screen: GeometryProxy) -> [Criterion] {
        let values = dataManager.incompleteCriteria
        
        let maxOnScreen = getMaxOnScreen(type: "criteria", width: screen.size.width)
        
        let sectionStart = section * maxOnScreen
        let sectionEnd = sectionStart + maxOnScreen
        
        return values.enumerated().filter { $0.offset >= sectionStart && $0.offset < sectionEnd }.map { $0.element }
    }
    
    func totalCriteriaSections(screen: GeometryProxy) -> Int {
        let count = dataManager.incompleteCriteria.count
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
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:aviate_one_cm", type: "minecraft:custom", factor: 100_000, icon: "rockets", secondaryIcon: "elytra", tooltip: L10n.Overlay.Complete.Stat.elytra, flipped: true))),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:bread", type: "minecraft:used", icon: "heal", secondaryIcon: "bread", tooltip: L10n.Overlay.Complete.Stat.bread))),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:enchant_item", type: "minecraft:custom", icon: "lapis_lazuli", secondaryIcon: "enchantment_table", tooltip: L10n.Overlay.Complete.Stat.enchant))),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:ender_pearl", type: "minecraft:used", icon: "ender_pearl", secondaryIcon: "ender_pearl", tooltip: L10n.Overlay.Complete.Stat.pearl, flipped: true))),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:tnt", type: "minecraft:mined", factor: 9, icon: "tnt", secondaryIcon: "sandstone", tooltip: L10n.Overlay.Complete.Stat.temples))),
            
            AnyView(Spacer()),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:creeper", type: "minecraft:killed", icon: "kill_all_mobs", secondaryIcon: "creeper"))),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:drowned", type: "minecraft:killed", icon: "kill_all_mobs", secondaryIcon: "drowned"))),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:wither_skeleton", type: "minecraft:killed", icon: "kill_all_mobs", secondaryIcon: "wither_skeleton"))),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:cod", type: "minecraft:killed", icon: "diamond_axe", secondaryIcon: "cod"))),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:salmon", type: "minecraft:killed", icon: "diamond_axe", secondaryIcon: "salmon"))),
            
            AnyView(Spacer()),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:netherrack", type: "minecraft:mined", icon: "diamond_pickaxe", secondaryIcon: "netherrack"))),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:gold_block", type: "minecraft:mined", icon: "diamond_pickaxe", secondaryIcon: "gold_block"))),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:ender_chest", type: "minecraft:mined", icon: "diamond_pickaxe", secondaryIcon: "ender_chest"))),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:lectern", type: "minecraft:mined", icon: "diamond_axe", secondaryIcon: "lectern"))),
            
            AnyView(FinalStatsView(stat: Statistic(id: "minecraft:sugar_cane", type: "minecraft:picked_up", icon: "diamond_axe", secondaryIcon: "sugarcane")))
        ]
    }
}
