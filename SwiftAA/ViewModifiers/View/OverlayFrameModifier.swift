//
//  OverlayFrameModifier.swift
//  SwiftAA
//
//  Created by Kihron on 9/10/23.
//

import SwiftUI

struct OverlayFrameModifier: ViewModifier {
    @ObservedObject private var overlayManager = OverlayManager.shared
    @ObservedObject private var dataManager = DataManager.shared
    
    func body(content: Content) -> some View {
        if !dataManager.allAdvancements {
            switch overlayManager.overlayStyle {
                case .tickerTape:
                    content
                        .frame(minWidth: 600, maxWidth: 1000, minHeight: 250, maxHeight: 250)
                case .multiPage:
                    content
                        .frame(minWidth: 400, maxWidth: .infinity, minHeight: 345, maxHeight: 345)
            }
        } else {
            content
                .frame(minWidth: 825, maxWidth: 1000, minHeight: 345, maxHeight: 345)
        }
    }
}

extension View {
    func applyOverlayFrame() -> some View {
        modifier(OverlayFrameModifier())
    }
}
