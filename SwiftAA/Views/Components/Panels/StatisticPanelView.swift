//
//  StatisticPanelView.swift
//  SwiftAA
//
//  Created by Kihron on 2/17/24.
//

import SwiftUI

struct StatisticPanelView: View {
    @ObservedObject private var dataManager = DataManager.shared
    @Binding var statistics: [StatisticIndicator]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach($statistics, id: \.id) { statistic in
                StatisticView(statistic: statistic)
            }
        }
        .padding(.leading, 9)
        .padding(.top, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .applyThemeModifiers()
    }
}

#Preview {
    StatisticPanelView(statistics: .constant([EnderPearls()]))
        .padding()
}
