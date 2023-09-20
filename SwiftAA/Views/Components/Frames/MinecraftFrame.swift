//
//  MinecraftFrame.swift
//  SwiftAA
//
//  Created by Kihron on 9/19/23.
//

import SwiftUI

struct MinecraftFrame: View {
    @Binding var indicator: Indicator
    
    var body: some View {
        Image("frame_mc_\(indicator.frameStyle)_\((indicator.completed ? "" : "in"))complete")
            .interpolation(.none)
            .resizable()
            .saturation((indicator.completed) ? 1.5 : 1)
            .brightness((indicator.completed) ? 0.15 : 0)
    }
}
