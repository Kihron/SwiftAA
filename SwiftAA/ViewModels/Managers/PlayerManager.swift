//
//  PlayerManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/10/23.
//

import SwiftUI

@MainActor @Observable class PlayerManager {
    var availablePlayers: [String] = []
    var uuid: String = ""
    
    static let shared = PlayerManager()
    
    private init() {}

    func getActivePlayerImageURL() -> URL? {
        guard let id = Settings[\.tracker].player?.id else { return nil }
        return getPlayerImageURL(for: id)
    }

    func getPlayerImageURL(for uuid: String?) -> URL? {
        guard let uuid else { return nil }
        return URL(string: "https://cravatar.eu/helmhead/\(uuid)/64.png")
    }

    func updatePlayer(to uuid: String?, shouldRefreshTracker: Bool = false) {
        guard let uuid else { return }

        if self.uuid != uuid {
            Task {
                Settings[\.tracker].player = await fetchPlayer(for: uuid)
                if shouldRefreshTracker {
                    TrackerEngine.shared.refreshTracker(immediateRefresh: true)
                }
            }
        }
    }

    private func fetchPlayer(for uuid: String) async -> Player? {
        guard let url = URL(string: "https://api.mojang.com/user/profile/\(uuid)") else { return nil }

        do {
            let player = try await URLSession.shared.decode(Player.self, from: url)
            return player
        } catch {
            print("Failed to decode Player for UUID \(uuid): \(error.localizedDescription)")
            return nil
        }
    }

    func updateAvailablePlayers(uuids: [String]) {
        self.availablePlayers = uuids
    }
}
