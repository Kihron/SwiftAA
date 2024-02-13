//
//  EnderDragonProgressBar.swift
//  SwiftAA
//
//  Created by Kihron on 2/11/24.
//

import SwiftUI

struct EnderDragonProgressBar: View {
    @State var item: GeometryProxy
    @Binding var value: Int
    @Binding var total: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack(spacing: 0) {
                Image("bar_ender_dragon_inactive_left")
                Image("bar_ender_dragon_inactive_middle")
                    .resizable()
                    .frame(width: max(0,  CGFloat(Int(item.size.width) - 40)), height: 10)
                Image("bar_ender_dragon_inactive_right")
            }
            
            HStack(spacing: 0) {
                if (value > 0) {
                    Image("bar_ender_dragon_active_left")
                    Image("bar_ender_dragon_active_middle")
                        .resizable()
                        .frame(width: CGFloat(max(0, (Int(item.size.width) * value / total) - (value >= total ? 40 : 20))), height: 10)
                    if (value >= total) {
                        Image("bar_ender_dragon_active_right")
                    }
                }
            }
        }
    }
}

#Preview {
    GeometryReader { geo in
        EnderDragonProgressBar(item: geo, value: .constant(1), total: .constant(20))
    }
    .padding(10)
}
