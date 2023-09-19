//
//  LeaderboardEntryRank.swift
//  SwiftAA
//
//  Created by Kihron on 9/16/23.
//

import SwiftUI

struct LeaderboardEntryRank: View {
    let placement: Int
    
    var rank: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        let number = formatter.string(from: NSNumber(value: placement + 1))
        return number ?? ""
    }
    
    var body: some View {
        VStack {
            Text(placement == 0 ? "WR" : rank)
                .font(.custom("Minecraft-Regular", size: 10))
                .padding(.horizontal, 2)
                .frame(height: 15)
                .frame(minWidth: 25)
                .background(
                    Rectangle()
                        .fill(Color("frame_modern_background"))
                        .border(getColor().gradient, width: 1)
                )
        }
        .frame(maxWidth: 42, alignment: .leading)
    }
    
    private func getColor() -> Color {
        switch placement {
            case 0:
                return .yellow
            case 1:
                return .white
            case 2:
                return .orange
            default:
                return .gray
        }
    }
}

#Preview {
    LeaderboardEntryRank(placement: 1)
        .padding()
}
