//
//  Advancement.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI
import Quartz

struct IndicatorView: View {
    @Binding var indicator: Indicator
    
    var body: some View {
        VStack(spacing: 3) {
            ZStack {
                Image("frame_mc_\(indicator.frameStyle)_\((indicator.completed ? "" : "in"))complete")
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 52, height: 52)
                    .padding([.top, .leading, .trailing], 6)
                    .saturation((indicator.completed) ? 1.5 : 1)
                    .brightness((indicator.completed) ? 0.15 : 0)
                    .overlay {
                        if (indicator.completed) {
                           Image("frame_glow")
                                .interpolation(.none)
                                .resizable()
                                .brightness(0.3)
                                .saturation(1.7)
                                .frame(width: 128, height: 128)
                                .padding([.top, .leading, .trailing], 6)
                        }
                    }

                if (isAnimated(icon: indicator.icon)) {
                    QLImage(indicator.icon)
                        .frame(width: 32, height: 32)
                        .padding(.top, 6)
                } else {
                    Image(indicator.icon)
                        .interpolation(.none)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .padding(.top, 6)
                }
            }
            
            Text(indicator.name)
                .font(.custom("Minecraft-Regular", size: 10))
                .multilineTextAlignment(.center)
                .frame(height: 24, alignment: .top)
                .padding(.top, -2)
        }
        .frame(width: 74)
    }
    
    func isAnimated(icon: String) -> Bool {
        return ["enchant_item", "enchanted_golden_apple", "summon_wither"].contains(icon)
    }
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView(indicator: .constant(Advancement(id: "bullseye", name: "Bullseye", icon: "enter_end_gateway", frameStyle: "normal", criteria: [], completed: false)))
            .frame(width: 100, height: 100)
    }
}
