//
//  MinecraftFrame.swift
//  SwiftAA
//
//  Created by Kihron on 9/19/23.
//

import SwiftUI

struct MinecraftFrame: View {
    @ObservedObject private var layoutManager = LayoutManager.shared
    @Binding var indicator: Indicator
    
    private var isCompleted: Bool {
        return indicator.completed && !layoutManager.infoMode
    }
    
    var body: some View {
        Image("frame_mc_\(indicator.frameStyle)_\((isCompleted ? "" : "in"))complete")
            .interpolation(.none)
            .resizable()
            .saturation(isCompleted ? 1.5 : 1)
            .brightness(isCompleted ? 0.15 : 0)
    }
}
