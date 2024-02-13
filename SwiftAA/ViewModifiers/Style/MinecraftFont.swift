//
//  MinecraftFont.swift
//  SwiftAA
//
//  Created by Andrew on 2/13/24.
//

import SwiftUI

struct MinecraftFont: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content.font(.custom("minecraft-regular", size: size))
    }
}

extension View {
    func minecraftFont(size: CGFloat = 10) -> some View {
        self.modifier(MinecraftFont(size: size))
    }
}

#Preview {
    Text("Text!")
        .minecraftFont().padding()
}
