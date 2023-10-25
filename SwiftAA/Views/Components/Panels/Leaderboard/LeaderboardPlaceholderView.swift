//
//  LeaderboardPlaceholderView.swift
//  SwiftAA
//
//  Created by Kihron on 9/19/23.
//

import SwiftUI

struct LeaderboardPlaceholderView: View {
    let placement: Int
    
    var body: some View {
        HStack {
            ZStack {
                Image("steve_avatar")
                    .frame(width: 32)
                    .padding(.leading, 10)
                    .shadow(color: getColor().opacity(0.5), radius: 10)
                
                LeaderboardEntryRank(placement: .constant(placement))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(y: -5)
            }
            .frame(width: 42)
            
            VStack(spacing: 3) {
                HStack {
                    Text("----")
                        .font(.custom("Minecraft-Regular", size: 10))
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text("--/--/--")
                        .font(.custom("Minecraft-Regular", size: 10))
                }
                
                HStack {
                    Text("--:--:--")
                        .font(.custom("Minecraft-Regular", size: 10))
                    
                    Spacer()
                    
                    Text("----")
                        .font(.custom("Minecraft-Regular", size: 10))
                }
            }
            .applyThemeText()
        }
        .frame(height: 32)
    }
    
    private func getColor() -> Color {
        switch placement {
            case 1:
                return .yellow
            case 2:
                return .white
            case 3:
                return .orange
            default:
                return .gray
        }
    }
}

#Preview {
    LeaderboardPlaceholderView(placement: 1)
        .frame(width: 196)
        .padding()
}
