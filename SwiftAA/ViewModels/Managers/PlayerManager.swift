//
//  PlayerManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/10/23.
//

import SwiftUI

class PlayerManager: ObservableObject {
    @AppStorage("player") var player: Player? = nil
    
    @Published var uuid: String = "" {
        didSet {
            Task {
                await updatePlayer(uuid: uuid)
            }
        }
    }
    
    static let shared = PlayerManager()
    
    init() {
        
    }
    
    var playerHasLoaded: Bool {
        guard let player = player else { return false }
        return !player.id.isEmpty
    }
    
    var imageURL: URL? {
        let id = player?.id ?? ""
        return URL(string: "https://cravatar.eu/helmhead/\(id)/64.png")
    }
    
    func updatePlayerUUID(uuid: String) {
        if self.uuid != uuid {
            self.uuid = uuid
        }
    }
    
    private func updatePlayer(uuid: String) async {
        guard let url = URL(string: "https://api.mojang.com/user/profile/\(uuid)") else { return }
        
        do {
            let player = try await URLSession.shared.decode(Player.self, from: url)
            DispatchQueue.main.async {
                self.player = player
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
