//
//  GoldyApple.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class GodlyApple: StatisticIndicator {
    var id: String = "minecraft:recipes/misc/mojang_banner_pattern"
    var key: String = L10n.Statistic.godApple
    var name: String = "God Apple"
    var icon: String = "enchanted_golden_apple"
    var completed: Bool = false
    
    static let shared = GodlyApple()
    
    func update(progress: ProgressManager) {
        completed = progress.advancementCompleted(id)
    }
}
