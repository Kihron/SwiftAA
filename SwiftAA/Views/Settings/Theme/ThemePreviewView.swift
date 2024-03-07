//
//  ThemePreviewView.swift
//  SwiftAA
//
//  Created by Kihron on 9/6/23.
//

import SwiftUI

struct ThemePreviewView: View {
    @State var theme: Theme
    
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(theme.backgroundColor)
            
            Rectangle()
                .fill(theme.borderColor)
            
            Rectangle()
                .fill(theme.textColor)
        }
        .frame(width: 100, height: 67)
        .roundedCorners(radius: 5, corners: [.allCorners])
    }
}

#Preview {
    ThemePreviewView(theme: ThemePreset.enderPearl)
}
