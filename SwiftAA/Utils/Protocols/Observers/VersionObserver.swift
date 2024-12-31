//
//  VersionObserver.swift
//  SwiftAA
//
//  Created by Kihron on 12/29/24.
//

import SwiftUI

@MainActor protocol VersionObserver: AnyObject, Sendable {
    func handleVersionChange(to version: Version) async throws
}

extension VersionObserver {
    func setupVersionObserver() {
        NotificationCenter.default.addObserver(forName: .didVersionChange, object: nil, queue: .main) { [weak self] notification in
            guard let self else { return }
            if let version = notification.userInfo?["version"] as? Version {
                Task {
                    try await self.handleVersionChange(to: version)
                }
            }
        }
    }
}
