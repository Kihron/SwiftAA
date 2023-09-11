//
//  OverlayManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/8/23.
//

import SwiftUI

class OverlayManager: ObservableObject {
    @AppStorage("overlayStyle") var overlayStyle: OverlayStyle = .tickerTape
    @AppStorage("overlayOpen") var overlayOpen: Bool = false
    @AppStorage("showStatistics") var showStatistics: Bool = true
    @AppStorage("statisticsAlignment") var statisticsAlignment: HAlignment = .leading
    @AppStorage("showLegacyPageBar") var showLegacyPageBar: Bool = true
    
    static let shared = OverlayManager()
    
    init() {
        
    }
}
