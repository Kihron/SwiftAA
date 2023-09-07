//
//  ThemeExampleView.swift
//  SwiftAA
//
//  Created by Kihron on 9/6/23.
//

import SwiftUI

struct ThemeExampleView: View {
    @ObservedObject private var themeManager = UIThemeManager.shared
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .fill(themeManager.background)
                    
                    Text("Bg")
                        .foregroundStyle(themeManager.text)
                        .padding(.bottom, 5)
                }
                
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .fill(themeManager.border)
                    
                    Text("Br")
                        .foregroundStyle(themeManager.background)
                        .padding(.bottom, 5)
                }
                
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .fill(themeManager.text)
                    
                    Text("T")
                        .foregroundStyle(themeManager.background)
                        .padding(.bottom, 5)
                }
            }
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
