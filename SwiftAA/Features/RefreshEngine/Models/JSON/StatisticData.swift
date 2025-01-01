//
//  StatisticData.swift
//  SwiftAA
//
//  Created by Kihron on 1/1/25.
//

import SwiftUI

struct StatisticData: Codable {
    var stats: [String:[String:Int]]
    var dataVersion: Int

    enum CodingKeys: String, CodingKey {
        case stats
        case dataVersion = "DataVersion"
    }
}
