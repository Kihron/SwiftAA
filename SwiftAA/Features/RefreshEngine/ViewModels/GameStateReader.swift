//
//  GameStateReader.swift
//  SwiftAA
//
//  Created by Kihron on 12/29/24.
//

import SwiftUI

@Observable class GameStateReader: VersionObserver {
    init() {
        setupVersionObserver()
    }

    func handleVersionChange(to version: Version) async throws {
        print("Changed to version \(version)")
    }
}
