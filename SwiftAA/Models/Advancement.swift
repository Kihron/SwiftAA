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
    var shortName: String?
    var icon: String
    var frameStyle: String
    var criteria: [Criterion]
    var completed: Bool
    var tooltip: String
    var timestamp: Date?
    
    func update(progress: ProgressManager) {
        completed = progress.advancementCompleted(id)
        timestamp = progress.advancementTimestamp(id)
        criteria.forEach { criterion in
            criterion.timestamp = progress.criterionCompleted(id, criterion.id)
        }
    }
    
    init(id: String, key: String, name: String, shortName: String? = nil, icon: String, frameStyle: String, criteria: [Criterion], completed: Bool, tooltip: String = "") {
        self.id = id
        self.key = key
        self.name = name
        self.shortName = shortName
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
        
        init(first: Advancement, second: Advancement, shortName: String? = nil) {
            self.first = first
            self.second = second
            super.init(id: first.id, key: first.key, name: first.name, shortName: shortName, icon: first.icon, frameStyle: first.frameStyle, criteria: first.criteria, completed: first.completed && second.completed)
        }
        
        required init(from decoder: Decoder) throws {
            fatalError("init(from:) has not been implemented for DualAdvancement")
        }
        
        override func update(progress: ProgressManager) {
            let firstDone = progress.advancementCompleted(first.id)
            let secondDone = progress.advancementCompleted(second.id)
            completed = firstDone && secondDone
        }
    }
}

extension Advancement: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .item)
    }
    
    static let defaultValue = Advancement(id: "", key: "", name: "", icon: "", frameStyle: "", criteria: [], completed: false)
}
