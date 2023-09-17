//
//  LeaderboardEntryView.swift
//  SwiftAA
//
//  Created by Kihron on 9/16/23.
//

import SwiftUI
import CachedAsyncImage

struct LeaderboardEntryView: View {
    @State var entry: LeaderboardEntry
    let placement: Int
    
    var body: some View {
        HStack {
            ZStack {
                CachedAsyncImage(url: getAvatarURL())
                    .frame(width: 32)
                    .padding(.leading, 10)
                    .shadow(color: getColor().opacity(0.5), radius: 10)
                
                LeaderboardEntryRank(placement: placement)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(y: -5)
            }
            .frame(width: 42)
            
            VStack(spacing: 3) {
                HStack {
                    Text(entry.name)
                        .font(.custom("Minecraft-Regular", size: 10))
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(entry.date)
                        .font(.custom("Minecraft-Regular", size: 10))
                        .applyThemeText()
                }
                .applyThemeText()
                
                HStack {
                    Text(entry.igt)
                        .font(.custom("Minecraft-Regular", size: 10))
                        .applyThemeText()
                    
                    Spacer()
                    
                    Text(entry.verification.label.localized)
                        .font(.custom("Minecraft-Regular", size: 10))
                        .foregroundStyle(getVerificationColor())
                }
            }
        }
        .frame(height: 32)
    }
    
    private func getAvatarURL() -> URL? {
        return URL(string: "https://minotar.net/helm/\(entry.name)/32")
    }
    
    private func getVerificationColor() -> Color {
        switch entry.verification {
            case .verified:
                return .green
            case .awaitingVerification:
                return .yellow
            case .notSubmitted:
                return .gray
            case .unknown:
                return UIThemeManager.shared.text
        }
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
    LeaderboardEntryView(entry: LeaderboardEntry(name: "Feinberg", igt: "2:25:30", date: "23 August 2023", verification: .verified), placement: 1)
        .frame(width: 196)
        .padding()
}
