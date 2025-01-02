//
//  TrackerSettings.swift
//  SwiftAA
//
//  Created by Kihron on 12/29/24.
//

import SwiftUI
import Combine

extension Preferences {
    struct TrackerSettings: Codable, Hashable {
        var customSavesPath: String = "" {
            didSet {
                sendCustomSavesPathChangeNotification(old: oldValue)
            }
        }

        var trackingMode: TrackingMode = .seamless
        var layoutStyle: LayoutStyle = .standard

        var gameVersion: Version = .v1_16 {
            didSet {
                sendVersionChangeNotification(old: oldValue)
            }
        }

        var automaticVersionDetection: Bool = true
        var automaticExpansion: Bool = true

        var player: Player? = nil

        private var cancellable: AnyCancellable?

        init() {}

        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.customSavesPath = try container.decodeIfPresent(String.self, forKey: .customSavesPath) ?? ""

            self.trackingMode = try container.decodeIfPresent(TrackingMode.self, forKey: .trackingMode) ?? .seamless
            self.layoutStyle = try container.decodeIfPresent(LayoutStyle.self, forKey: .layoutStyle) ?? .standard

            self.gameVersion = try container.decodeIfPresent(Version.self, forKey: .gameVersion) ?? .v1_16
            self.automaticVersionDetection = try container.decodeIfPresent(Bool.self, forKey: .automaticVersionDetection) ?? true

            self.automaticExpansion = try container.decodeIfPresent(Bool.self, forKey: .automaticExpansion) ?? true

            self.player = try container.decodeIfPresent(Player.self, forKey: .player)
        }

        enum CodingKeys: String, CodingKey {
            case customSavesPath
            case trackingMode
            case layoutStyle
            case gameVersion
            case automaticVersionDetection
            case automaticExpansion
            case player
        }

        private func sendVersionChangeNotification(old version: Version) {
            if version != gameVersion {
                NotificationCenter.default.post(
                    name: .didVersionChange,
                    object: nil,
                    userInfo: ["version": gameVersion]
                )
            }
        }

        mutating private func sendCustomSavesPathChangeNotification(old path: String) {
            if path != customSavesPath {
                cancellable?.cancel()
                cancellable = Just(customSavesPath)
                    .delay(for: .milliseconds(300), scheduler: RunLoop.main)
                    .sink { _ in
                        NotificationCenter.default.post(
                            name: .didCustomSavesPathChange,
                            object: nil
                        )
                    }
            }
        }
    }
}
