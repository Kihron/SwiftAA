//
//  GodApple.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

class GodApple: TransferableIndicator, StatusIndicator {
    var type: StatusType = .godApple
    var id: String = "minecraft:recipes/misc/mojang_banner_pattern"
    var key: String = L10n.Statistic.GodApple.obtain
    var name: String = "Obtain God Apple"
    var icon: String = "enchanted_golden_apple"
    var frameStyle: String = "statistic"
    var completed: Bool = false
    var tooltip: String = ""
    
    func update(progress: ProgressManager) {
        completed = progress.advancementCompleted(id)
        key = completed ? L10n.Statistic.GodApple.obtained : L10n.Statistic.GodApple.obtain
    }
}
