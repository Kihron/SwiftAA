//
//  Preferences.swift
//  SwiftAA
//
//  Created by Kihron on 12/29/24.
//

import SwiftUI

struct Preferences: Codable, Hashable {
    var tracker: TrackerSettings = .init()
    var player: PlayerSettings = .init()

    init() {}

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tracker = try container.decodeIfPresent(TrackerSettings.self, forKey: .tracker) ?? .init()
        self.player = try container.decodeIfPresent(PlayerSettings.self, forKey: .player) ?? .init()
    }
}
