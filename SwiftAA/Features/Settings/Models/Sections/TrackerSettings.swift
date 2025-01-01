//
//  TrackerSettings.swift
//  SwiftAA
//
//  Created by Kihron on 12/29/24.
//

import SwiftUI

extension Preferences {
    struct TrackerSettings: Codable, Hashable {
        var customSavesPath: String = ""

        var trackingMode: TrackingMode = .seamless
        var layoutStyle: LayoutStyle = .standard

        var gameVersion: Version = .v1_16 {
            didSet {
                sendVersionChangeNotification(old: oldValue)
            }
        }

        var automaticVersionDetection: Bool = true
        var automaticExpansion: Bool = true

        init() {}

        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.customSavesPath = try container.decodeIfPresent(String.self, forKey: .customSavesPath) ?? ""

            self.trackingMode = try container.decodeIfPresent(TrackingMode.self, forKey: .trackingMode) ?? .seamless
            self.layoutStyle = try container.decodeIfPresent(LayoutStyle.self, forKey: .layoutStyle) ?? .standard

            self.gameVersion = try container.decodeIfPresent(Version.self, forKey: .gameVersion) ?? .v1_16
            self.automaticVersionDetection = try container.decodeIfPresent(Bool.self, forKey: .automaticVersionDetection) ?? true

            self.automaticExpansion = try container.decodeIfPresent(Bool.self, forKey: .automaticExpansion) ?? true
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
    }
}
