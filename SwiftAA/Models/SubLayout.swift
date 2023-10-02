//
//  SubLayout.swift
//  SwiftAA
//
//  Created by Kihron on 10/1/23.
//

import SwiftUI

struct SubLayout: Codable {
    let categories: [String]
    let advancements: [SubAdvancement]
}

struct SubAdvancement: Codable {
    let id, name: String
}
