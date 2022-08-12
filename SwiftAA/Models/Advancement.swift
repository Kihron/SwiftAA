//
//  Advancement.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI

class Advancement: NSObject, Indicator, Identifiable {
    var id: String
    var key: String
    var name: String
    var icon: String
    var frameStyle: String
    var criteria: [Criterion]
    var completed: Bool
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        self.completed = advancements[id]?.done ?? false
        self.criteria.forEach { criterion in
            criterion.completed = advancements[id]?.criteria[criterion.id] != nil
        }
    }
    
    init(id: String, key: String, name: String, icon: String, frameStyle: String, criteria: [Criterion], completed: Bool) {
        self.id = id
        self.key = key
        self.name = name
        self.icon = icon
        self.frameStyle = frameStyle
        self.criteria = criteria
        self.completed = completed
    }
    
    public override var description: String {
        return "\(self.name) \(self.completed)"
    }
}
