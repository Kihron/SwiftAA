//
//  PlayerSettings.swift
//  SwiftAA
//
//  Created by Kihron on 12/31/24.
//

extension Preferences {
    struct PlayerSettings: Hashable, Codable {
        var player: Player? = nil

        init() {}

        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.player = try container.decodeIfPresent(Player.self, forKey: .player)
        }
    }
}
