//
//  SettingsObserver.swift
//  SwiftAA
//
//  Created by Kihron on 12/29/24.
//

import SwiftUI

@MainActor protocol SettingsObserver {

}

extension SettingsObserver {
    private var preferences: Preferences {
        return Settings.shared.preferences
    }
}
