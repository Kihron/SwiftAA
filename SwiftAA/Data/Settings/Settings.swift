//
//  Settings.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/21/22.
//

import SwiftUI

class AppSettings: ObservableObject {
    @AppStorage("gameVersion") var gameVersion: String = "1.16"
    @AppStorage("customSavesPath") var customSavesPath: String = ""
    @AppStorage("trackingMode") var trackingMode: TrackingMode = .seamless
}

enum TrackingMode: String {
    case seamless, directory
}
