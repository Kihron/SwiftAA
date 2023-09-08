//
//  InfiniteScroller.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 9/7/23.
//

import SwiftUI

struct InfiniteScroller<Content: View>: View {
    var contentWidth: CGFloat
    var content: Content
    
    @State
    var xOffset: CGFloat = 0
    
    init(contentWidth: CGFloat, @ViewBuilder content: () -> Content) {
        self.contentWidth = contentWidth
        self.content = content()
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                content
                content
            }
            .offset(x: xOffset, y: 0)
        }
        .disabled(true)
        .onAppear {
            let animationDuration = Double(contentWidth) / 74.0
            withAnimation(.linear(duration: animationDuration).repeatForever(autoreverses: false)) {
                xOffset = -contentWidth
            }
        }
    }
}
