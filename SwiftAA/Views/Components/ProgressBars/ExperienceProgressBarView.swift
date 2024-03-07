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
    
    private var segmentCount: Int {
        return Int((item.size.width - 40) / 20)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            let leftOver = item.size.width.truncatingRemainder(dividingBy: 20) / 2
            HStack(spacing: 0) {
                Image("bar_experience_inactive_left")
                    .resizable()
                    .interpolation(.none)
                    .frame(width: leftOver + 20)
                
                ForEach(0..<segmentCount, id: \.self) { _ in
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
                    let activeSegments = max(0, min(segmentCount, (segmentCount + 1) * value / total))
                    
                    Image("bar_experience_active_left")
                        .resizable()
                        .interpolation(.none)
                        .frame(width: leftOver + 20)
                    
                    if activeSegments >= 2 {
                        ForEach(0..<activeSegments, id: \.self) { _ in
                            Image("bar_experience_active_middle")
                                .resizable()
                                .interpolation(.none)
                                .frame(width: 20)
                        }
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
