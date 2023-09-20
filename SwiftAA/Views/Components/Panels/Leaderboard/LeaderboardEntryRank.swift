//
//  LeaderboardEntryRank.swift
//  SwiftAA
//
//  Created by Kihron on 9/16/23.
//

import SwiftUI

struct LeaderboardEntryRank: View {
    @Binding var placement: Int
    
    var rank: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        let number = formatter.string(from: NSNumber(value: placement))
        return number ?? ""
    }
    
    var body: some View {
        VStack {
            Text(placement == 1 ? "WR" : rank)
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
    LeaderboardEntryRank(placement: .constant(1))
        .padding()
}
