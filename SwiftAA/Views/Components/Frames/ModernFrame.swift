//
//  ModernFrame.swift
//  SwiftAA
//
//  Created by Kihron on 9/19/23.
//

import SwiftUI

struct ModernFrame: View {
    @Binding var indicator: Indicator
    
    var body: some View {
        ZStack {
            if indicator.completed {
                Group {
                    Image("frame_modern_back_complete")
                    
                    Image("frame_modern_border_complete")
                }
                .brightness(0.1)
                .saturation(1.7)
            } else {
                Image("frame_modern_back")
                    .renderingMode(.template)
                    .foregroundStyle(Color("frame_modern_background"))
                
                Image("frame_modern_border")
                    .renderingMode(.template)
                    .foregroundStyle(.gray)
            }
        }
    }
}
