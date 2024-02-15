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
    @Binding var showTooltip: Bool
    var isOverlay: Bool
    
    var body: some View {
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
        } else {
            Image(indicator.icon)
                .interpolation(.none)
                .resizable()
                .frame(width: 32, height: 32)
                .padding(.top, 6)
                .onHover(perform: { hovering in
                    showTooltip = layoutManager.infoMode && !isOverlay && hovering
                })
        }
    }
}
