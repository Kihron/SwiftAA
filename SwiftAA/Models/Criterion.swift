//
//  Criterion.swift
//  SwiftAA
//
//  Created by Kihron on 7/19/22.
//

import SwiftUI

class Criterion: NSObject, Codable, Identifiable {
    var id: String
    var key: String
    var name: String
    var icon: String
    var timestamp: Date?
    
    var completed: Bool {
        return timestamp != nil
    }
    
    init(id: String, key: String, name: String, icon: String) {
        self.id = id
        self.key = key
        self.name = name
        self.icon = icon
    }
    
    public override var description: String {
        "\(name) \(completed)"
    }
    
    class DualCriterion: Criterion {
        var recipe: String
        var secondaryTimestamp: Date?
        
        var secondaryCompleted: Bool {
            return secondaryTimestamp != nil
        }
        
        required init(from decoder: Decoder) throws {
            fatalError("init(from:) has not been implemented for DualCriterion")
        }
        
        init(id: String, key: String, name: String, icon: String, recipe: String) {
            self.recipe = recipe
            self.secondaryTimestamp = nil
            super.init(id: id, key: key, name: name, icon: icon)
        }
    }
}
