//
//  TrackerManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI

class TrackerManager: ObservableObject {
    @AppStorage("customSavesPath") var customSavesPath: String = ""
    @AppStorage("trackingMode") var trackingMode: TrackingMode = .seamless
    @AppStorage("layoutStyle") var layoutStyle: LayoutStyle = .standard
    @AppStorage("gameVersion") var gameVersion: Version = .v1_16
    
    @Published var lastDirectoryUpdate: Date? = Date.now
    @Published var lastLogUpdate: Date? = Date.now
    
    @Published var worldPath: String = ""
    @Published var alert: TrackerAlert? = .none
    
    var worldShortPath: String {
        let name = worldPath.lastIndex(of: "/") ?? worldPath.startIndex
        return String(worldPath.suffix(from: name))
    }
    
    static let shared = TrackerManager()
    
    init() {
        
    }
    
    func resetWorldPath() {
        worldPath = ""
        lastDirectoryUpdate = Date.now
    }
}
