//
//  IndicatorIconView.swift
//  SwiftAA
//
//  Created by Kihron on 2/14/24.
//

import SwiftUI

struct IndicatorIconView: View {
    @ObservedObject private var layoutManager = LayoutManager.shared
    @Binding var indicator: Indicator
    
    @State private var isVisible: Bool = false
    var isOverlay: Bool
    var isStat: Bool
    
    private var isAnimated: Bool {
        guard Constants.animatedIcons.contains(indicator.icon) else { return false }
        return (isStat || !isOverlay) || OverlayManager.shared.overlayStyle != .multiPage
    }
    
    var body: some View {
        VStack {
            if indicator.icon.contains("+") {
                LazyVGrid(columns: [GridItem(.fixed(16), spacing: 2), GridItem(.fixed(16), spacing: 2)], spacing: 2) {
                    ForEach(indicator.icon.split(separator: "+"), id: \.self) {icon in
                        Image(String(icon))
                            .resizable()
                            .interpolation(.none)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                    }
                }
                .frame(width: 32, height: 32)
                .padding(.top, 6)
            } else if isAnimated {
                if isVisible {
                    AnimatedIconView(icon: indicator.icon)
                        .frame(width: 32, height: 32)
                        .padding(.top, 6)
                }
            } else {
                Image(indicator.icon)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.top, 6)
            }
        }
        .onAppear {
            isVisible = true
        }
        .onDisappear {
            isVisible = false
        }
    }
}
