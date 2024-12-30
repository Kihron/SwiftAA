//
//  GameStateReader.swift
//  SwiftAA
//
//  Created by Kihron on 12/29/24.
//

import SwiftUI

@Observable class GameStateReader: VersionObserver, SettingsObserver {
    init() {
        setupVersionObserver()
    }

    func handleVersionChange(to version: Version) async throws {

    }
}
