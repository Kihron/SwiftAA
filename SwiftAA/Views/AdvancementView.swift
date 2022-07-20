//
//  Advancement.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI

struct AdvancementView: View {
    @State var indicator: Indicator
    
    var body: some View {
        VStack {
            ZStack {
                Image("frame_mc_\(indicator.frameStyle)_\((indicator.completed ? "" : "in"))complete")
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 52, height: 52)
                    .padding([.top, .leading, .trailing], 6)
                    .overlay {
                        if (indicator.completed) {
                           Image("frame_glow")
                                .interpolation(.none)
                                .resizable()
                                .brightness(0.25)
                                .saturation(1.7)
                                .frame(width: 128, height: 128)
                                .padding([.top, .leading, .trailing], 6)
                        }
                    }

                Image(indicator.icon)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.top, 6)
            }
            
            Text("City at the end of the")
                .font(.custom("Minecraft-Regular", size: 10))
                .foregroundColor(.clear)
                .overlay {
                    Text(indicator.name)
                        .font(.custom("Minecraft-Regular", size: 10))
                        .multilineTextAlignment(.center)
                }
        }
        .frame(width: 74)
    }
}

struct AdvancementView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancementView(indicator: Advancement(id: "bullseye", name: "City at the End of the Game", icon: "bullseye", frameStyle: "challenge", completed: true))
            .frame(width: 100, height: 150)
    }
}
