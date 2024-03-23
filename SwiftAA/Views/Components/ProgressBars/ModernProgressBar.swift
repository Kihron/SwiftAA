//
//  ModernProgressBar.swift
//  SwiftAA
//
//  Created by Kihron on 3/22/24.
//

import SwiftUI

struct ModernProgressBar: View {
    @State var item: GeometryProxy
    @Binding var value: Int
    @Binding var total: Int
    
    private var gradientWidth: CGFloat {
        max(CGFloat(value) / CGFloat(total) * item.size.width, 0)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color("frame_modern_background"))
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 1)
            
            HStack {
                if value > 0 {
                    HStack(spacing: 0) {
                        Image("bar_modern_active_left")
                        
                        Image("bar_modern_active_middle")
                            .resizable()
                            .frame(width: CGFloat(max(0, (Int(item.size.width) * value / total) - (value >= total ? 40 : 20))))
                        
                        if value >= total {
                            Image("bar_modern_active_right")
                        } else {
                            Image("bar_modern_active_edge")
                        }
                    }
                    .brightness(0.1)
                    .overlay {
                        RadialGradient(gradient: Gradient(colors: [.white.opacity(0.3), .clear]), center: .center, startRadius: 0, endRadius: gradientWidth / 2)
                            .mask(gradientMask)
                            .shadow(color: .white, radius: 2)
                    }
                }
            }
        }
        .frame(height: 10)
    }
    
    private var gradientMask: some View {
        HStack(spacing: 0) {
            Circle()
                .frame(width: 10, height: 10)
            
            Rectangle()
            
            Circle()
                .frame(width: 10, height: 10)
        }
        .frame(width: gradientWidth)
        .blur(radius: 2)
    }
}

#Preview {
    GeometryReader { geo in
        ModernProgressBar(item: geo, value: .constant(1), total: .constant(20))
    }
    .padding(10)
}
