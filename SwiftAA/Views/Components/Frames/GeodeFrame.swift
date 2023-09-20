//
//  GeodeFrame.swift
//  SwiftAA
//
//  Created by Kihron on 9/19/23.
//

import SwiftUI

struct GeodeFrame: View {
    @Binding var indicator: Indicator
    
    var body: some View {
        ZStack {
            if indicator.completed {
                Group {
                    Image("frame_geode_back_complete")
                    
                    Image("frame_geode_border_complete")
                        .brightness(0.1)
                }
                .saturation(1.7)
            } else {
                Group {
                    Image("frame_geode_back")
                        .brightness(0.05)
                    
                    Image("frame_geode_border")
                        .saturation(1.1)
                        .brightness(0.1)
                }
            }
        }
    }
}
