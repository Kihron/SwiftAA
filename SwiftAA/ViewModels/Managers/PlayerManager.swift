//
//  PlayerManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/10/23.
//

import SwiftUI

class PlayerManager: ObservableObject {
    @AppStorage("player") var player: Player? = nil
    @Published var availablePlayers: [String] = []

    @Published var uuid: String = "" {
        didSet {
            Task { @MainActor in
                self.player = await fetchPlayer(for: uuid)
            }
        }
    }
    
    static let shared = PlayerManager()
    
    init() {
        
    }

    func getActivePlayerImageURL() -> URL? {
        guard let id = player?.id else { return nil }
        return getPlayerImageURL(for: id)
    }

    func getPlayerImageURL(for uuid: String?) -> URL? {
        guard let uuid else { return nil }
        return URL(string: "https://cravatar.eu/helmhead/\(uuid)/64.png")
    }

    func updatePlayerUUID(uuid: String?) {
        guard let uuid else { return }

        if self.uuid != uuid {
            self.uuid = uuid
        }
    }

    func updateAvailablePlayers(uuids: [String]) {
        self.availablePlayers = uuids
    }

    @MainActor private func fetchPlayer(for uuid: String) async -> Player? {
        guard let url = URL(string: "https://api.mojang.com/user/profile/\(uuid)") else { return nil }

        do {
            let player = try await URLSession.shared.decode(Player.self, from: url)
            return player
        } catch {
            print("Failed to decode Player for UUID \(uuid): \(error.localizedDescription)")
            return nil
        }
    }
}
