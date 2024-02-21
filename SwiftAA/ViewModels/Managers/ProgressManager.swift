//
//  ProgressManager.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import SwiftUI

class ProgressManager: ObservableObject {
    @ObservedObject private var dataManager = DataManager.shared
    
    @Published var advancementsState: [String:JsonAdvancement] = [:]
    @Published var statisticsState: [String:[String:Int]] = [:]
    
    private var playTime: Int = 0
    private var wasCleared: Bool = false
    
    static let shared = ProgressManager()
    
    init() {
        
    }
    
    func updateProgressState(advancements: [String:JsonAdvancement], statistics: [String:[String:Int]]) {
        advancementsState = advancements
        statisticsState = statistics
        updateIndicators()
    }
    
    func clearProgressState() {
        if advancementsState.isEmpty && !wasCleared {
            dataManager.lastModified = Date.now
            wasCleared = true
        } else if !advancementsState.isEmpty {
            wasCleared = false
        }
        
        advancementsState.removeAll()
        statisticsState.removeAll()
        updateIndicators()
    }
    
    func advancementCompleted(_ id: String) -> Bool {
        return advancementsState[id]?.done ?? false
    }
    
    func advancementTimestamp(_ id: String) -> Date? {
        return advancementsState[id]?.criteria.compactMap({Utilities.convertToTimestamp($0.value)}).max()
    }
    
    func criterionCompleted(_ advancement: String, _ criterion: String) -> Date? {
        return advancementsState[advancement]?.criteria[criterion].flatMap(Utilities.convertToTimestamp)
    }
    
    func timesPickedUp(_ id: String) -> Int {
        return statisticsState["minecraft:picked_up"]?[id] ?? 0
    }
    
    func timesDropped(_ id: String) -> Int {
        return statisticsState["minecraft:dropped"]?[id] ?? 0
    }
    
    func timesMined(_ id: String) -> Int {
        return statisticsState["minecraft:mined"]?[id] ?? 0
    }
    
    func timesCrafted(_ id: String) -> Int {
        return statisticsState["minecraft:crafted"]?[id] ?? 0
    }
    
    func timesUsed(_ id: String) -> Int {
        return statisticsState["minecraft:used"]?[id] ?? 0
    }
    
    func wasKilled(_ id: String) -> Bool {
        return statisticsState["minecraft:killed"]?[id] ?? 0 > 0
    }
    
    func getSpecialStatistic(type: String, id: String) -> Int {
        return statisticsState[type]?[id] ?? 0
    }
    
    func getInGameTime() -> String {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.hour, .minute, .second]
        dateFormatter.unitsStyle = .positional
        dateFormatter.zeroFormattingBehavior = .pad
        return dateFormatter.string(from: Double(playTime / 20)) ?? "0:00:00"
    }
    
    private func updateIndicators() {
        dataManager.allAdvancements.forEach { adv in
            adv.update(progress: self)
        }
        
        dataManager.statusIndicators.forEach { status in
            status.update(progress: self)
        }
        
        dataManager.statisticIndicators.forEach { statistic in
            statistic.update(progress: self)
        }
        
        dataManager.uncounted.forEach { adv in
            adv.update(progress: self)
        }
        
        dataManager.updateAdvancementFields()
        if !dataManager.completedAllAdvancements {
            updateInGameTime()
        }
    }
    
    private func updateInGameTime() {
        let timeStatistic = TrackerManager.shared.gameVersion == .v1_16 ? "minecraft:play_one_minute" : "minecraft:play_time"
        playTime = statisticsState["minecraft:custom"]?[timeStatistic] ?? 0
    }
}
