//
//  ProgressManager.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import SwiftUI

@MainActor @Observable class ProgressManager {
    var advancementsState: [String:AdvancementData] = [:]
    var statisticsState: [String:[String:Int]] = [:]
    
    private var advancementManager: AdvancementManager = .shared

    private var playTime: Int = 0
    private var wasCleared: Bool = false
    
    static let shared = ProgressManager()
    
    private init() {}
    
    func updateProgressState(advancements: [String:AdvancementData], statistics: [String:[String:Int]]) {
        advancementsState = advancements
        statisticsState = statistics
        updateIndicators()
    }
    
    func clearProgressState() {
        if advancementsState.isEmpty && !wasCleared {
            TrackerEngine.shared.trackerLog.lastRefresh = .now
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
        return Utilities.playTimeFormatter.string(from: Double(playTime / 20)) ?? "0:00:00"
    }
    
    private func updateIndicators() {
        advancementManager.allAdvancements.forEach { adv in
            adv.update(progress: self)
        }
        
        advancementManager.statusIndicators.forEach { status in
            status.update(progress: self)
        }
        
        advancementManager.statisticIndicators.forEach { statistic in
            statistic.update(progress: self)
        }
        
        advancementManager.uncountedAdvancements.forEach { adv in
            adv.update(progress: self)
        }
        
        advancementManager.updateAdvancementFields()
        if !advancementManager.completedAllAdvancements {
            updateInGameTime()
        }
    }
    
    private func updateInGameTime() {
        let isPreviousKey = [.v1_16, .v1_16_5].contains(TrackerManager.shared.gameVersion)
        let timeStatistic = isPreviousKey ? "minecraft:play_one_minute" : "minecraft:play_time"
        playTime = statisticsState["minecraft:custom"]?[timeStatistic] ?? 0
    }
}
