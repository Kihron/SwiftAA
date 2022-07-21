//
//  Advancement.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI

struct AdvancementView: View {
    @State var indicator: Indicator
//    @State var angle: Double = 0.0
//    @State var isAnimating = false
//    
//    var foreverAnimation: Animation {
//        Animation.linear(duration: 2.0)
//            .repeatForever(autoreverses: false)
//    }
    
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
//                                .rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0))
//                                .animation(self.foreverAnimation)
//                                .onAppear {
//                                    self.isAnimating = true
//                            }
                        }
                    }

                Image(indicator.icon)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.top, 6)
            }
            
            Text(indicator.name)
                .font(.custom("Minecraft-Regular", size: 10))
                .multilineTextAlignment(.center)
                .frame(height: 24, alignment: .top)
                .padding(.top, -2)
        }
        .frame(width: 74)
    }
}

struct AdvancementView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancementView(indicator: Advancement(id: "bullseye", name: "Bullseye", icon: "bullseye", frameStyle: "challenge", criteria: [], completed: true))
            .frame(width: 100, height: 100)
    }
}
