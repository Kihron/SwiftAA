//
//  TrackerSettings.swift
//  SwiftAA
//
//  Created by Kihron on 12/29/24.
//

import SwiftUI

extension Preferences {
    struct TrackerSettings: Codable, Hashable {
        var gameVersion: Version = .v1_16

        init() {}

        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.gameVersion = try container.decodeIfPresent(Version.self, forKey: .gameVersion) ?? .v1_16
        }
    }
}
