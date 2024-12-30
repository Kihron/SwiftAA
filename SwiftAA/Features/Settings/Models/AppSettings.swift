//
//  AppSettings.swift
//  SwiftAA
//
//  Created by Kihron on 12/30/24.
//

import SwiftUI

@propertyWrapper
@MainActor struct AppSettings<T>: DynamicProperty where T: Equatable {
    var settings: Environment<T>

    let keyPath: WritableKeyPath<Preferences, T>

    init(_ keyPath: WritableKeyPath<Preferences, T>) {
        self.keyPath = keyPath
        let settingsKeyPath = (\EnvironmentValues.settings).appending(path: keyPath)
        self.settings = Environment(settingsKeyPath)
    }

    var wrappedValue: T {
        get {
            Settings.shared.preferences[keyPath: keyPath]
        }
        nonmutating set {
            Settings.shared.preferences[keyPath: keyPath] = newValue
        }
    }

    var projectedValue: Binding<T> {
        Binding {
            Settings.shared.preferences[keyPath: keyPath]
        } set: {
            Settings.shared.preferences[keyPath: keyPath] = $0
        }
    }
}

extension EnvironmentValues {
    @Entry var settings: Preferences = .init()
}
