//
//  TrackingSettingsViewModel.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 9/5/23.
//

import SwiftUI

class TrackingSettingsViewModel: ObservableObject {
    init() {
        
    }
    
    func openFinderWindow() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        if panel.runModal() == .OK {
            TrackerManager.shared.customSavesPath = panel.url?.path ?? ""
        }
        NSApp.keyWindow?.makeFirstResponder(nil)
    }
}
