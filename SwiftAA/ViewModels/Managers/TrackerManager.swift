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
    
    @AppStorage("automaticVersionDetection") var automaticVersionDetection: Bool = true
    @AppStorage("gameVersion") var gameVersion: Version = .v1_16 {
        didSet {
            DataManager.shared.gameVersionChanged()
        }
    }
    
    @Published var lastDirectoryUpdate: Date? = Date.now
    @Published var lastLogUpdate: Date? = Date.now
    
    @Published var worldPath: String = ""
    @Published var alert: TrackerAlert? = .none
    
    
    var lastWorking = ""
    
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
        DataManager.shared.lastModified = Date.now
        ProgressManager.shared.clearProgressState()
    }
    
    @discardableResult func updateGameVersion(version: Version) -> Bool {
        if gameVersion != version {
            DispatchQueue.main.async {
                self.gameVersion = version
            }
            return true
        } else {
            return false
        }
    }
    
    @discardableResult func updateErrorAlert(alert: TrackerAlert?) -> Bool {
        if self.alert != alert {
            self.alert = alert
            return true
        } else {
            return false
        }
    }
}
