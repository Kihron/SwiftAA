//
//  StatusIndicatorRowView.swift
//  SwiftAA
//
//  Created by Kihron on 10/17/23.
//

import SwiftUI

struct StatusIndicatorRowView: View {
    @ObservedObject private var overlayManager = OverlayManager.shared
    @ObservedObject private var dataManager = DataManager.shared
    
    @State private var showStatusEditor: Bool = false
    
    private var filteredStatusIndicators: [Binding<Indicator>] {
        return $dataManager.stats.filter({ overlayManager.activeIndicators.contains($0.wrappedValue.id)
        })
    }
    
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
        HStack(spacing: 0) {
            if overlayManager.showStatistics {
                if alignment == .trailing {
                    pinnedButton
                }
                
                ForEach(filteredStatusIndicators, id: \.self.wrappedValue.id) { adv in
                    IndicatorView(indicator: adv, isOverlay: true, isStat: true)
                }
                
                if alignment != .trailing {
                    pinnedButton
                }
            }
        }
        .sheet(isPresented: $showStatusEditor, content: {
            StatusIndicatorPickerView()
        })
        .animation(.spring, value: overlayManager.statisticsAlignment)
        .animation(.easeIn(duration: 0.2), value: overlayManager.isHovering)
        .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder var pinnedButton: some View {
        if overlayManager.isHovering {
            Button(action: { showStatusEditor.toggle() }) {
                Image(systemName: "pin.fill")
                    .scaleEffect(1.5)
                    .padding(.bottom, 14)
                    .rotationEffect(.degrees(45))
            }
            .buttonStyle(.plain)
        } else {
            Rectangle()
                .fill(.clear)
                .frame(width: 16, height: 16)
        }
    }
}

#Preview {
    StatusIndicatorRowView()
}
