//
//  Trims.swift
//  SwiftAA
//
//  Created by Kihron on 2/19/24.
//

import Foundation

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
                dual.secondaryTimestamp = progress.criterionCompleted(id, dual.id)
            }
        }
    }
}
