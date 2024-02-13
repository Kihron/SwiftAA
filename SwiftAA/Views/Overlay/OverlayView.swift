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
            Group {
                if !dataManager.allAdvancements {
                    switch overlayManager.overlayStyle {
                        case .optimal:
                            OptimalOverlayView()
                        case .tickerTape:
                            TickerTapeOverlayView()
                        case .multiPage:
                            MultiPageOverlayView()
                    }
                } else {
                    OverlayCompletedView()
                }
            }
            .onHover(perform: { hovering in
                overlayManager.isHovering = hovering
            })
        } else {
            ProgressView()
        }
    }
}

#Preview {
    OverlayView()
        .padding(.vertical)
}
