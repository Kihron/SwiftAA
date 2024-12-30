//
//  Settings.swift
//  SwiftAA
//
//  Created by Kihron on 12/29/24.
//

import SwiftUI
import Combine

@MainActor @Observable class Settings {
    private let filemanager = FileManager.default

    static let shared = Settings()

    var preferences: Preferences

    private var storeTask: AnyCancellable!

    private init() {
        self.preferences = .init()
        self.preferences = loadSettings()
        observePreferences()
    }

    private func observePreferences() {
        withObservationTracking {
            _ = preferences
        } onChange: { [weak self] in
            Task {
                try? await self?.savePreferences()
                await self?.observePreferences()
            }
        }
    }

    private func loadSettings() -> Preferences {
        if !filemanager.fileExists(atPath: settingsURL.path) {
            try? filemanager.createDirectory(at: baseURL, withIntermediateDirectories: false)
            return .init()
        }

        guard let json = try? Data(contentsOf: settingsURL),
                let prefs = try? JSONDecoder().decode(Preferences.self, from: json)
        else {
            return .init()
        }
        return prefs
    }

    private func savePreferences() throws {
        let data = try JSONEncoder().encode(preferences)
        let json = try JSONSerialization.jsonObject(with: data)
        let prettyJSON = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        try prettyJSON.write(to: settingsURL, options: .atomic)
    }

    private var baseURL: URL {
        filemanager
            .homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Application Support/SwiftAA", isDirectory: true)
    }

    private var settingsURL: URL {
        baseURL
            .appendingPathComponent("settings")
            .appendingPathExtension("json")
    }
}
