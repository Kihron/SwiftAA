//
//  NewOverlayView.swift
//  SwiftAA
//
//  Created by Kihron on 9/7/23.
//

import SwiftUI

struct OverlayView: View {
    @ObservedObject private var overlayManager = OverlayManager.shared
    @ObservedObject private var dataManager = DataManager.shared
    
    var body: some View {
        if overlayManager.overlayOpen {
            if !dataManager.allAdvancements {
                switch overlayManager.overlayStyle {
                    case .tickerTape:
                        TickerTapeOverlayView()
                    case .multiPage:
                        MultiPageOverlayView()
                }
            } else {
                OverlayCompletedView()
            }
        } else {
            ProgressView()
        }
    }
}

#Preview {
    OverlayView()
        .padding(.vertical)
}
