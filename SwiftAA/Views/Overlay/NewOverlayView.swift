//
//  NewOverlayView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 9/7/23.
//

import SwiftUI

struct NewOverlayView: View {
    var indicators = DataManager.shared.map.values.flatMap({$0}).filter({!$0.completed})
    
    var body: some View {
        GeometryReader { geometry in
            if !indicators.isEmpty {
                let displayCount = max(getMaxOnScreen(type: "indicator", width: geometry.size.width), indicators.count)
                // Repeat the elements if needed
                let repeatedIndicators = Array(repeating: indicators, count: displayCount/indicators.count).flatMap {$0}
                
                let contentWidth = 74 * CGFloat(repeatedIndicators.count)
                
                InfiniteScroller(contentWidth: contentWidth) {
                    HStack(spacing: 0) {
                        ForEach(repeatedIndicators, id: \.self) { indicator in
                            IndicatorView(indicator: .constant(indicator), isOverlay: true)
                        }
                    }
                }
            }
        }
    }
    
    func getMaxOnScreen(type: String, width: CGFloat) -> Int {
        switch type {
        case "indicator": return Int(floor(width / 74))
        default: return 0
        }
    }
}

#Preview {
    NewOverlayView()
        .padding(.vertical)
}
