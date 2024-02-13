//
//  OverlayManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/8/23.
//

import SwiftUI

class OverlayManager: ObservableObject {
    @AppStorage("overlayStyle") var overlayStyle: OverlayStyle = .optimal
    @AppStorage("overlayOpen") var overlayOpen: Bool = false
    @AppStorage("showStatistics") var showStatistics: Bool = true
    @AppStorage("statisticsAlignment") var statisticsAlignment: HAlignment = .leading
    @AppStorage("showLegacyPageIndicator") var showLegacyPageIndicator: Bool = true
    @AppStorage("clarifyAmbigiousCriteria") var clarifyAmbigiousCriteria: Bool = true
    
    @AppStorage("overlayFrameStyle") var overlayFrameStyle: FrameStyle = .minecraft
    @AppStorage("syncOverlayFrame") var syncOverlayFrame: Bool = true

    @AppStorage("activeStatusIndicators") private var activeStatusIndicators: String = Constants.defaultActiveStatusIndicators
    
    @Published var isHovering: Bool = false
    
    var activeIndicators: [String] {
        get { activeStatusIndicators.split(separator: ",").map { String($0) } }
        set { activeStatusIndicators = newValue.joined(separator: ",") }
    }
    
    static let shared = OverlayManager()
    
    init() {
        
    }
}
