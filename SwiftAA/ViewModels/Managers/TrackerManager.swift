//
//  VersionManager.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 9/5/23.
//

import SwiftUI

class TrackerManager: ObservableObject {
    @AppStorage("customSavesPath") var customSavesPath: String = ""
    @AppStorage("trackingMode") var trackingMode: TrackingMode = .seamless
    @AppStorage("gameVersion") var gameVersion: Version = .v1_16
    
    static let shared = TrackerManager()
    
    init() {
        
    }
}