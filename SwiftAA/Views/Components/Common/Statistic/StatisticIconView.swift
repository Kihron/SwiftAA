//
//  StatisticIconView.swift
//  SwiftAA
//
//  Created by Kihron on 2/25/24.
//

import SwiftUI

struct StatisticIconView: View {
    @Binding var statistic: StatisticIndicator
    @State private var isVisible: Bool = false
    
    var body: some View {
        if Constants.animatedIcons.contains(statistic.icon) {
            VStack {
                if isVisible {
                    AnimatedIconView(icon: statistic.icon)
                        .frame(width: 16, height: 16)
                }
            }
            .onAppear {
                isVisible = true
            }
            .onDisappear {
                isVisible = false
            }
        } else {
            Image(statistic.icon)
                .frame(width: 16, height: 16)
        }
    }
}
