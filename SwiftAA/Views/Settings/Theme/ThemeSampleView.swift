//
//  ThemeSampleView.swift
//  SwiftAA
//
//  Created by Kihron on 9/21/23.
//

import SwiftUI

struct ThemeSampleView: View {
    @Binding var background: Color
    @Binding var border: Color
    @Binding var text: Color
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(background)
                
                Text("Bg")
                    .foregroundStyle(text)
                    .padding(.bottom, 5)
            }
            
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(border)
                
                Text("Br")
                    .foregroundStyle(background)
                    .padding(.bottom, 5)
            }
            
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(text)
                
                Text("T")
                    .foregroundStyle(background)
                    .padding(.bottom, 5)
            }
        }
    }
}

#Preview {
    ThemeSampleView(background: .constant(UIThemeManager.shared.background), border: .constant(UIThemeManager.shared.border), text: .constant(UIThemeManager.shared.text))
        .padding()
}
