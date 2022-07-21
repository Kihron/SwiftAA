//
//  ProgressBarView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/20/22.
//

import SwiftUI

struct ProgressBarView: View {
    @State var value: Int
    @State var total: Int
    @State var title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("\(value) / \(total) \(title) (\(value * 100 / total)%)")
                .font(.custom("Minecraft-Regular", size: 10))
            
            GeometryReader { item in
                ZStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Image("bar_ender_dragon_inactive_left")
                        Image("bar_ender_dragon_inactive_middle")
                            .resizable()
                            .frame(width: CGFloat(Int(item.size.width) - 40), height: 10)
                        Image("bar_ender_dragon_inactive_right")
                    }
                    
                    HStack(spacing: 0) {
                        if (value > 0) {
                            Image("bar_ender_dragon_active_left")
                            Image("bar_ender_dragon_active_middle")
                                .resizable()
                                .frame(width: CGFloat(Int(item.size.width) * value / total) - (value >= total ? 40 : 20), height: 10)
                            if (value >= total) {
                                Image("bar_ender_dragon_active_right")
                            }
                        }
                    }
                }
            }
            .frame(height: 10)
        }
        .padding(5)
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(value: 20, total: 42, title: "Biomes Visited")
            .frame(width: 400, height: 100)
    }
}
