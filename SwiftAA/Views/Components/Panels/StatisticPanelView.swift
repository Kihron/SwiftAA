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
    
    @State var rowCount: Int
    
    var body: some View {
        LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 16), spacing: 1, alignment: .leading), count: rowCount)) {
            ForEach($statistics, id: \.id) { statistic in
                StatisticView(statistic: statistic)
            }
        }
        .padding(.leading, 9)
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .applyThemeModifiers()
    }
}

#Preview {
    StatisticPanelView(statistics: .constant([EnderPearls()]), rowCount: 4)
        .padding()
}
