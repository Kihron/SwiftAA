//
//  DonationView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 8/25/22.
//

import SwiftUI

struct DonationView: View {
    @State var show = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("donation_background"))
                .overlay {
                    Rectangle()
                        .fill(.clear)
                        .border(Color("donation_border"), width: 2)
                        .frame(width: 200, height: 50)
                }
                .shadow(color: Color("donation_background"), radius: 5, x: 0, y: 0)
            
            Rectangle()
                .fill(Color("donation_background"))
                .mask(
                    Capsule()
                        .fill(LinearGradient(gradient: .init(colors: [.clear,.white,.clear]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.init(degrees: 30))
                        .offset(x: self.show ? 350 : -430)
                )
            
            HStack {
                Image("enchantment_table")
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 32, height: 32)
                    
                Text("Support us on KoFi")
                    .font(.custom("Minecraft-Regular", size: 12))
                }
        }
        .frame(width: 200, height: 50)
        .onAppear {
            withAnimation(Animation.default.speed(0.05).delay(0).repeatForever(autoreverses: true)){
                self.show.toggle()
            }
        }
    }
}

struct DonationView_Previews: PreviewProvider {
    static var previews: some View {
        DonationView()
            .frame(width: 300, height: 300)
    }
}
