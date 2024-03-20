//
//  OverlayViewModel.swift
//  SwiftAA
//
//  Created by Kihron on 1/10/23.
//

import SwiftUI

class MultiPageOverlayViewModel: ObservableObject {
    private var dataManager = DataManager.shared
    
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
}
