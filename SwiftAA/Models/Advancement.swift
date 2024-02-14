//
//  Advancement.swift
//  SwiftAA
//
//  Created by Kihron on 7/19/22.
//

import SwiftUI

class Advancement: NSObject, Indicator, Identifiable, Codable {
    var id: String
    var key: String
    var name: String
    var icon: String
    var frameStyle: String
    var criteria: [Criterion]
    var completed: Bool
    var tooltip: String
    var timestamp: Date?
    
    func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
        completed = advancements[id]?.done ?? false
        timestamp = advancements[id]?.criteria.compactMap({Utilities.convertToTimestamp($0.value)}).max()
        criteria.forEach { criterion in
            criterion.timestamp = advancements[id]?.criteria[criterion.id].flatMap(Utilities.convertToTimestamp)
        }
    }
    
    init(id: String, key: String, name: String, icon: String, frameStyle: String, criteria: [Criterion], completed: Bool, tooltip: String = "") {
        self.id = id
        self.key = "advancement.\(key.replacingOccurrences(of: "-", with: "."))"
        self.name = name
        self.icon = icon
        self.frameStyle = frameStyle
        self.criteria = criteria
        self.completed = completed
        self.tooltip = tooltip
    }
    
    public override var description: String {
        "\(name) \(completed)"
    }
    
    class DualAdvancement: Advancement {
        let first: Advancement
        let second: Advancement
        
        init(first: Advancement, second: Advancement) {
            self.first = first
            self.second = second
            super.init(id: first.id, key: first.key, name: first.name, icon: first.icon, frameStyle: first.frameStyle, criteria: first.criteria, completed: first.completed && second.completed)
        }
        
        required init(from decoder: Decoder) throws {
            fatalError("init(from:) has not been implemented for DualAdvancement")
        }
        
        override func update(advancements: [String : JsonAdvancement], stats: [String : [String : Int]]) {
            let firstDone = advancements[first.id]?.done ?? false
            let secondDone = advancements[second.id]?.done ?? false
            completed = firstDone && secondDone
        }
    }
}

extension Advancement: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .item)
    }
}
