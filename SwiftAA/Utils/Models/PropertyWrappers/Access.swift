//
//  Access.swift
//  SwiftAA
//
//  Created by Kihron on 12/31/24.
//

import SwiftUI

@propertyWrapper
@MainActor struct Access<T>: DynamicProperty {
    @Environment(\.accessEntries) private var accessEntries
    private let keyPath: KeyPath<AccessEntries, T>

    init(_ keyPath: KeyPath<AccessEntries, T>) {
        self.keyPath = keyPath
    }

    var wrappedValue: T {
        accessEntries[keyPath: keyPath]
    }

    var projectedValue: T {
        wrappedValue
    }
}

@MainActor @Observable class AccessEntries {
    var advancementManager: AdvancementManager = .shared
    var trackerEngine: TrackerEngine = .shared
    var playerManager: PlayerManager = .shared

    static let shared: AccessEntries = .init()

    private init() {}
}

@MainActor extension EnvironmentValues {
    @Entry var accessEntries: AccessEntries = .shared
}

