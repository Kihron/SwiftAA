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
    
    init(id: String, key: String, name: String, icon: String, frameStyle: String, criteria: [Criterion], completed: Bool) {
        super.init(id: id, key: key, name: name, icon: icon, frameStyle: frameStyle, criteria: criteria, completed: completed)
    }
    
    override func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        super.update(advancements: advancements, stats: stats)
        criteria.forEach { criterion in
            if let dual = criterion as? Criterion.DualCriterion {
                if let timestampString = advancements[dual.recipe]?.criteria.values.first {
                    dual.timestamp = Utilities.convertToTimestamp(timestampString)
                } else {
                    dual.timestamp = nil
                }
                
                if let timestampString = advancements[id]?.criteria[dual.id] {
                    dual.secondaryTimestamp = Utilities.convertToTimestamp(timestampString)
                } else {
                    dual.secondaryTimestamp = nil
                }
            }
        }
    }
}
