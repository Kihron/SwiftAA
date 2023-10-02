//
//  IndicatorInfoView.swift
//  SwiftAA
//
//  Created by Kihron on 10/1/23.
//

import SwiftUI

struct IndicatorInfoView: View {
    @ObservedObject private var themeManager = UIThemeManager.shared
    @State var tooltip: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(themeManager.background)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(themeManager.border, lineWidth: 2)
                }
            
            Text(tooltip)
                .multilineTextAlignment(.center)
                .padding(10)
        }
        .frame(width: 250)
        .padding(5)
    }
}

#Preview {
    IndicatorInfoView(tooltip: "Test")
        .padding()
}
