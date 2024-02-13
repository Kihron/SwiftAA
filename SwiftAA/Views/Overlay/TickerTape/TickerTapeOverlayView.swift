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
    
    var counter: String {
        return "\(dataManager.completedAdvancements.count) / \(dataManager.totalAdvancements)"
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
            
            StatusIndicatorRowView()
                .frame(height: 70)
                .padding(.bottom)
        }
    }
}

#Preview {
    TickerTapeOverlayView()
}
