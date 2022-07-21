//
//  Advancement.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI

protocol Indicator {
    var id: String { get set }
    var name: String { get set }
    var icon: String { get set }
    var frameStyle: String { get set }
    var completed: Bool { get set }
}

struct Advancement: Indicator, Identifiable {
    var id: String
    var name: String
    var icon: String
    var frameStyle: String
    var criteria: [Criterion]
    var completed: Bool
}
