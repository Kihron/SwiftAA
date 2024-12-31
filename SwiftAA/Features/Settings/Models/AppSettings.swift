//
//  AppSettings.swift
//  SwiftAA
//
//  Created by Kihron on 12/30/24.
//

import SwiftUI

@propertyWrapper
@MainActor struct AppSettings<T>: DynamicProperty where T: Equatable {
    @StateObject var settings: Settings = .shared

    let keyPath: WritableKeyPath<Preferences, T>

    init(_ keyPath: WritableKeyPath<Preferences, T>) {
        self.keyPath = keyPath
    }

    var wrappedValue: T {
        get {
            settings.preferences[keyPath: keyPath]
        }
        nonmutating set {
            settings.preferences[keyPath: keyPath] = newValue
        }
    }

    var projectedValue: Binding<T> {
        Binding {
            settings.preferences[keyPath: keyPath]
        } set: {
            settings.preferences[keyPath: keyPath] = $0
        }
    }
}
