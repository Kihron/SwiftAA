//
//  ThemeExampleView.swift
//  SwiftAA
//
//  Created by Kihron on 9/6/23.
//

import SwiftUI

struct ThemeExampleView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        ZStack {
            ThemeSampleView(background: .constant(themeManager.background), border: .constant(themeManager.border), text: .constant(themeManager.text))
                .frame(width: 100, height: 67)
                .roundedCorners(radius: 5, corners: [.allCorners])
                .padding(.vertical)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(LinearGradient(colors: [.white.opacity(0.04), .clear], startPoint: .bottom, endPoint: .top))
    }
}

#Preview {
    ThemeExampleView()
        .padding()
}
