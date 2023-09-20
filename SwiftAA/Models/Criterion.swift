//
//  Criterion.swift
//  SwiftAA
//
//  Created by Kihron on 7/19/22.
//

import SwiftUI

class Criterion: NSObject, Codable {
    var id: String
    var key: String
    var name: String
    var icon: String
    var completed: Bool
    
    init(id: String, key: String, name: String, icon: String, completed: Bool) {
        self.id = id
        self.key = "advancement.\(key.replacingOccurrences(of: "-", with: "."))"
        self.name = name
        self.icon = icon
        self.completed = completed
    }
    
    public override var description: String {
        "\(name) \(completed)"
    }
}
