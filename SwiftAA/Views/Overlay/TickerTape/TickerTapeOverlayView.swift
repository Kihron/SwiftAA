//
//  TickerTapeOverlayView.swift
//  SwiftAA
//
//  Created by Kihron on 9/10/23.
//

import SwiftUI

struct TickerTapeOverlayView: View {
    @ObservedObject private var overlayManager = OverlayManager.shared
    @ObservedObject private var progressManager = ProgressManager.shared
    @ObservedObject private var dataManager = DataManager.shared
    
    var counter: String {
        return "\(dataManager.completedAdvancements.count) / \(dataManager.allAdvancements.count)"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(counter)
                    .minecraftFont(size: 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                if overlayManager.showInGameTime {
                    Text("IGT: \(progressManager.getInGameTime())")
                        .minecraftFont(size: 12)
                        .padding(.trailing, 10)
                }
            }
            
            if overlayManager.overlayOpen {
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
}

#Preview {
    TickerTapeOverlayView()
}
