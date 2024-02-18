//
//  StatisticView.swift
//  SwiftAA
//
//  Created by Kihron on 2/17/24.
//

import SwiftUI

struct StatisticView: View {
    @Binding var statistic: StatisticIndicator
    
    var body: some View {
        HStack {
            Image(statistic.icon)
                .frame(width: 16, height: 16)
            
            Text(statistic.key)
                .minecraftFont()
                .applyThemeText()
        }
        .opacity(statistic.completed ? 1 : 0.3)
    }
}
