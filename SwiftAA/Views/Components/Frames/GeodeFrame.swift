//
//  GeodeFrame.swift
//  SwiftAA
//
//  Created by Kihron on 9/19/23.
//

import SwiftUI

struct GeodeFrame: View {
    @ObservedObject private var layoutManager = LayoutManager.shared
    @Binding var indicator: Indicator
    
    private var isCompleted: Bool {
        return indicator.completed && (!layoutManager.infoMode || !indicator.tooltip.isEmpty)
    }
    
    var body: some View {
        ZStack {
            if isCompleted {
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
