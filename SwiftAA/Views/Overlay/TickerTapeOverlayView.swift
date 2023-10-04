//
//  TickerTapeOverlayView.swift
//  SwiftAA
//
//  Created by Kihron on 9/10/23.
//

import SwiftUI

struct TickerTapeOverlayView: View {
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
    
    var counter: String {
        return "\(dataManager.completedAdvancements) / \(dataManager.totalAdvancements)"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(counter)
                .font(.custom("Minecraft-Regular", size: 12))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
            
            CriteriaTickerTapeView()
                .frame(height: 40)
            
            IndicatorTickerTapeView()
                .frame(height: 90)
            
            HStack {
                if overlayManager.showStatistics {
                    ForEach($dataManager.stats, id: \.self.id) { adv in
                        if isAnimated(icon: adv.wrappedValue.icon) {
                            IndicatorView(indicator: adv, isOverlay: true, isStat: true)
                        } else {
                            IndicatorView(indicator: adv, isOverlay: true, isStat: true)
                                .drawingGroup()
                        }
                    }
                    .transition(.opacity)
                }
            }
            .animation(.spring, value: overlayManager.statisticsAlignment)
            .frame(maxWidth: .infinity, alignment: alignment)
            .frame(height: 70)
            .padding(.bottom)
        }
    }
    
    private func isAnimated(icon: String) -> Bool {
        ["enchant_item", "enchanted_golden_apple", "summon_wither", "skulk_sensor"].contains(icon)
    }
}

#Preview {
    TickerTapeOverlayView()
}
