//
//  ComplexAdvancements.swift
//  SwiftAA
//
//  Created by Slackow on 2/13/24.
//

import SwiftUI

class TrimAdvancement: Advancement {
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented for ComplexAdvancement")
    }
    
    init(id: String, key: String, name: String, shortName: String? = nil, icon: String, frameStyle: String, criteria: [Criterion], completed: Bool) {
        super.init(id: id, key: key, name: name, shortName: shortName, icon: icon, frameStyle: frameStyle, criteria: criteria, completed: completed)
    }
    
    override func update(progress: ProgressManager) {
        super.update(progress: progress)
        criteria.forEach { criterion in
            if let dual = criterion as? Criterion.DualCriterion {
                dual.timestamp = progress.advancementTimestamp(dual.recipe)
                dual.secondaryTimestamp = progress.criterionCompleted(advancement: id, criterion: dual.id)
            }
        }
    }
}
