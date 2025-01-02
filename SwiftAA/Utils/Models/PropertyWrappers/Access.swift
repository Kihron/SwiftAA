//
//  Access.swift
//  SwiftAA
//
//  Created by Kihron on 12/31/24.
//

import SwiftUI

/// A property wrapper that provides access to shared instances of core services within the app.
///
/// Use the `@Access` property wrapper to bind a property to a specific key path in the ``AccessEntries``
/// model, enabling seamless retrieval of shared services throughout your SwiftUI views.
///
/// ```swift
/// @Access(\.someService) var someService: SomeType
/// ```
///
/// - Note: The `@Access` property wrapper relies on the `AccessEntries` class, which holds shared instances
///   of the core services. Ensure that `AccessEntries` is properly configured in the environment.
///
/// - Parameters:
///   - keyPath: A key path to a specific service within the `AccessEntries` class.
///
/// - SeeAlso: ``AccessEntries``
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

/// A container for shared instances of core services within the app.
///
/// The `AccessEntries` class holds singleton instances of various managers, providing centralized access
/// to these services throughout the application. Each manager is initialized as a shared instance, ensuring
/// consistent and synchronized interactions across different parts of the app.
///
/// - Note: The `AccessEntries` class is designed to be used in conjunction with the `@Access` property wrapper,
///   which facilitates seamless integration of these shared services into SwiftUI views.
///
/// - SeeAlso: ``Access``
@MainActor @Observable class AccessEntries {
    var advancementManager: AdvancementManager = .shared
    var metricManager: MetricManager = .shared
    var trackerEngine: TrackerEngine = .shared
    var playerManager: PlayerManager = .shared
    var progressManager: ProgressManager = .shared
    var networkManager: NetworkManager = .shared
    var leaderboardManager: LeaderboardManager = .shared

    static let shared: AccessEntries = .init()

    private init() {}
}

@MainActor extension EnvironmentValues {
    @Entry var accessEntries: AccessEntries = .shared
}

