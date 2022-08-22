//
//  ContentView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI

struct AdvPanelView: View {
    @EnvironmentObject var settings: AppSettings
    @Binding var indicators: [Indicator]
    @State var columnCount: Int
    @State var isStat: Bool = false
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 64), spacing: 0), count: columnCount), spacing: 0) {
            ForEach($indicators, id: \.self.id) { adv in
                IndicatorView(indicator: adv, isStat: isStat)
            }
        }
        .padding(4)
        .background(settings.backgroudColor)
        .border(settings.borderColor, width: 2)
    }
}

struct AdvPanelViewView_Previews: PreviewProvider {
    @ObservedObject static var dataHandler = DataHandler()
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        AdvPanelView(indicators: dataHandler.decode(file: "adventure"), columnCount: 2)
            .frame(width: 300, height: 500)
            .environmentObject(settings)
    }
}
