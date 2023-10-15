//
//  OverlayShimmerView.swift
//  SwiftAA
//
//  Created by Kihron on 8/25/22.
//

import SwiftUI

struct OverlayShimmerView: View {
    @State var message: String
    @State private var show = false
    
    var body : some View{
        ZStack{
            ZStack{
                Text(message)
                    .foregroundColor(.purple)
                    .font(.custom("Minecraft-Regular", size: 24))
                    .multilineTextAlignment(.center)
                
                Text(message)
                    .font(.custom("Minecraft-Regular", size: 24))
                    .multilineTextAlignment(.center)
                    .mask(
                        Capsule()
                            .fill(LinearGradient(gradient: .init(colors: [.clear,.white,.clear]), startPoint: .top, endPoint: .bottom))
                            .rotationEffect(.init(degrees: 30))
                            .offset(x: self.show ? 350 : -430)
                    )
            }
        }
        .onAppear {
            withAnimation(Animation.default.speed(0.05).delay(0).repeatForever(autoreverses: false)){
                self.show.toggle()
            }
        }
    }
}

struct OverlayShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayShimmerView(message: "This is a test!\nThis is a longer test to see how well this works")
            .frame(width: 800, height: 300)
    }
}
