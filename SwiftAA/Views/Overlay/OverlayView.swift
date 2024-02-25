//
//  NewOverlayView.swift
//  SwiftAA
//
//  Created by Kihron on 9/7/23.
//

import SwiftUI

struct OverlayView: View {
    @Environment(\.controlActiveState) private var controlActiveState
    
    @ObservedObject private var overlayManager = OverlayManager.shared
    @ObservedObject private var dataManager = DataManager.shared
    
    var body: some View {
        VStack {
            if overlayManager.overlayOpen {
                Group {
                    if !dataManager.completedAllAdvancements {
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
        .onReceive(NotificationCenter.default.publisher(for: NSWindow.willCloseNotification)) { newValue in
            overlayManager.closeOverlay()
        }
        .onChange(of: controlActiveState) { newValue in
            switch newValue {
                case .key, .active:
                    overlayManager.overlayOpen = true
                default:
                    break
            }
        }
    }
}

#Preview {
    OverlayView()
        .padding(.vertical)
}
