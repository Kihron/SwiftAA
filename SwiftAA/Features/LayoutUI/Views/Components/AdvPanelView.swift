//
//  ContentView.swift
//  SwiftAA
//
//  Created by Kihron on 7/19/22.
//

import SwiftUI

struct AdvPanelView: View {
//    @ObservedObject private var dataManager = DataManager.shared
    
    @Binding var indicators: [Indicator]
    @State var columnCount: Int
    @State var isStat: Bool = false
    @State var isMinimal: Bool = false
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 64), spacing: 0), count: columnCount), spacing: 0) {
            ForEach($indicators, id: \.self.id) { adv in
                IndicatorView(indicator: adv, isStat: isStat, isMinimal: isMinimal)
            }
        }
        .padding(4)
        .frame(maxHeight: .infinity)
        .applyThemeModifiers()
    }
}

struct AdvPanelViewView_Previews: PreviewProvider {
    @ObservedObject static var dataManager = DataManager()
    
    static var previews: some View {
        AdvPanelView(indicators: dataManager.getCategoryAdvancements(category: "adventure"), columnCount: 2)
            .frame(width: 300, height: 500)
    }
}
