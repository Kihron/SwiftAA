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
    @AppStorage("showLegacyPageIndicator") var showLegacyPageIndicator: Bool = true
    @AppStorage("clarifyAmbigiousCriteria") var clarifyAmbigiousCriteria: Bool = true
    
    @AppStorage("overlayFrameStyle") var overlayFrameStyle: FrameStyle = .minecraft
    @AppStorage("syncOverlayFrame") var syncOverlayFrame: Bool = true

    @AppStorage("nonActiveStatusIndicators") private var nonActiveStatusIndicators: String = ""
    
    var nonActiveIndicators: [String] {
        get { nonActiveStatusIndicators.split(separator: ",").map { String($0) } }
        set { nonActiveStatusIndicators = newValue.joined(separator: ",") }
    }
    
    @Published var isHovering: Bool = false
    
    static let shared = OverlayManager()
    
    init() {
        
    }
}
