//
//  ProgressObserver.swift
//  SwiftAA
//
//  Created by Kihron on 12/31/24.
//

import SwiftUI

@MainActor protocol ProgressObserver: AnyObject, Sendable {
    func handleProgressChange() async throws
}

extension ProgressObserver {
    func setupProgressObserver() {
        NotificationCenter.default.addObserver(forName: .didProgressChange, object: nil, queue: .main) { [weak self] notification in
            guard let self else { return }
            Task { try await self.handleProgressChange() }
        }
    }
}
