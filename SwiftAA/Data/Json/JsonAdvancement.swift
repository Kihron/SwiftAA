//
//  JsonAdvancement.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/21/22.
//

import SwiftUI

struct JsonAdvancement: Codable {
    var criteria: [String:String]
    var done: Bool
}

struct JsonStats: Codable {
    var stats: [String:[String:Int]]
    var DataVersion: Int
}
