//
//  OverlayManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/8/23.
//

import SwiftUI

class OverlayManager: ObservableObject {
    @AppStorage("overlayStyle") var overlayStyle: OverlayStyle = .tickerTape
    @AppStorage("showStatistics") var showStatistics: Bool = true
    @AppStorage("statisticsAlignment") var statisticsAlignment: HAlignment = .leading
    @AppStorage("showOptimalProgressBar") var showOptimalProgressBar: Bool = true
    @AppStorage("showLegacyPageIndicator") var showLegacyPageIndicator: Bool = true
    @AppStorage("clarifyAmbigiousCriteria") var clarifyAmbigiousCriteria: Bool = true
    @AppStorage("showInGameTime") var showInGameTime: Bool = true
    
    @AppStorage("invertScrollingDirection") var invertScrollDirection: Bool = false
    @AppStorage("tickerTapeSpeed") var tickerTapeSpeed: Double = 60
    
    @AppStorage("overlayFrameStyle") var overlayFrameStyle: FrameStyle = .minecraft
    @AppStorage("syncOverlayFrame") var syncOverlayFrame: Bool = true

    @AppStorage("activeStatusIndicators") private var activeStatusIndicators: String = Constants.defaultActiveStatusIndicators
    
    @AppStorage("overlayOpen") var overlayOpen: Bool = false {
        didSet {
            if !overlayOpen {
                closeOverlayWindow()
            }
        }
    }
    
    @Published var isHovering: Bool = false
    
    var activeIndicators: [String] {
        get { activeStatusIndicators.split(separator: ",").map { String($0) } }
        set { activeStatusIndicators = newValue.joined(separator: ",") }
    }
    
    static let shared = OverlayManager()
    
    init() {
        
    }
    
    func closeOverlay() {
        overlayOpen = false
    }
    
    private func closeOverlayWindow() {
        let windows = NSApplication.shared.windows.filter({ window in
            window.title == "Overlay Window"
        })
        
        guard let window = windows.first else {
            return
        }
        
        window.close()
    }
}
