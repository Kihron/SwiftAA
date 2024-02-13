//
//  ExperienceProgressBarView.swift
//  SwiftAA
//
//  Created by Kihron on 2/10/24.
//

import SwiftUI

struct ExperienceProgressBarView: View {
    @State var item: GeometryProxy
    @Binding var value: Int
    @Binding var total: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            let leftOver = item.size.width.truncatingRemainder(dividingBy: 20) / 2
            HStack(spacing: 0) {
                Image("bar_experience_inactive_left")
                    .resizable()
                    .interpolation(.none)
                    .frame(width: leftOver + 20)
                
                let repeatCount = Int((item.size.width - 40) / 20)
                ForEach(0..<repeatCount, id: \.self) { _ in
                    Image("bar_experience_inactive_middle")
                        .resizable()
                        .interpolation(.none)
                        .frame(width: 20)
                }
                
                Image("bar_experience_inactive_right")
                    .resizable()
                    .interpolation(.none)
            }
            
            HStack(spacing: 0) {
                if (value > 0) {
                    let repeatCount = max(Int(ceil(CGFloat(Int(item.size.width) * value / total) - 40) / 20), 0)
                    
                    Image("bar_experience_active_left")
                        .resizable()
                        .interpolation(.none)
                        .frame(width: leftOver + 20)
//                        .onAppear {
//                            print("Width: \(item.size.width), Repeat: \(repeatCount)")
//                        }
                    
                    ForEach(0..<repeatCount, id: \.self) { _ in
                        Image("bar_experience_active_middle")
                            .resizable()
                            .interpolation(.none)
                            .frame(width: 20)
                    }
                    
                    if (value >= total) {
                        Image("bar_experience_active_right")
                            .resizable()
                            .interpolation(.none)
                    }
                }
            }
        }
    }
}

#Preview {
    GeometryReader { geo in
        ExperienceProgressBarView(item: geo, value: .constant(1), total: .constant(20))
    }
    .padding(10)
}
