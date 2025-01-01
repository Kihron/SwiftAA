//
//  TrackerLog.swift
//  SwiftAA
//
//  Created by Kihron on 12/29/24.
//

import SwiftUI

@MainActor @Observable class TrackerLog {
    var progressManager: ProgressManager = .shared

    var lastWorkingDirectory: String = ""
    var lastRefresh: Date = Date.now

    var worldPath: String = ""
    var alert: TrackerAlert? = .none

    init() {

    }

    func resetWorldPath() {
        worldPath.removeAll()
        lastRefresh = Date.now
        progressManager.clearProgressState()
    }

    func getInstanceNumber() -> String {
        guard Settings[\.tracker].trackingMode == .seamless, let lastSave = lastWorkingDirectory.split(separator: "/").dropLast(2).last else {
            return ""
        }
        let instanceNumber = lastSave.suffix(2).filter({ $0.isNumber })
        return instanceNumber.count >= 1 ? "(\(instanceNumber)) " : ""
    }

    @discardableResult
    func updateErrorAlert(alert: TrackerAlert?) -> Bool {
        guard self.alert != alert else { return false }
        self.alert = alert
        return true
    }
}
