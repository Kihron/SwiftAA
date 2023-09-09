//
//  NewOverlayView.swift
//  SwiftAA
//
//  Created by Kihron on 9/7/23.
//

import SwiftUI

struct NewOverlayView: View {
    @ObservedObject private var overlayManager = OverlayManager.shared
    @ObservedObject private var dataManager = DataManager.shared
    
    var alignment: Alignment {
        switch overlayManager.statisticsAlignment {
            case .leading:
                .leading
            case .center:
                .center
            case .trailing:
                .trailing
        }
    }
    
    var body: some View {
        VStack {
            CriteriaTickerTapeView()
                .frame(height: 40)
            
            IndicatorTickerTapeView()
                .frame(height: 90)
            
            HStack {
                if overlayManager.showStatistics {
                    ForEach(dataManager.stats, id: \.self.id) { adv in
                        if isAnimated(icon: adv.icon) {
                            IndicatorView(indicator: .constant(adv), isOverlay: true, isStat: true)
                        } else {
                            IndicatorView(indicator: .constant(adv), isOverlay: true, isStat: true)
                                .drawingGroup()
                        }
                    }
                    .transition(.opacity)
                }
            }
            .animation(.spring, value: overlayManager.statisticsAlignment)
            .frame(height: 70)
            .frame(maxWidth: .infinity, alignment: alignment)
            .padding(.bottom)
        }
    }
    
    private func isAnimated(icon: String) -> Bool {
        ["enchant_item", "enchanted_golden_apple", "summon_wither", "skulk_sensor"].contains(icon)
    }
}

#Preview {
    NewOverlayView()
        .padding(.vertical)
}
