//
//  Category.swift
//  SwiftAA
//
//  Created by Kihron on 12/31/24.
//

enum Category: String, CaseIterable, Codable, Sendable {
    case adventure
    case end
    case husbandry
    case minecraft
    case nether
    case none

    var id: Self {
        return self
    }

    var label: String {
        return rawValue
    }
}
