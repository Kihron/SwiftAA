//
//  LeaderboardEntryView.swift
//  SwiftAA
//
//  Created by Kihron on 9/16/23.
//

import SwiftUI
import CachedAsyncImage

struct LeaderboardEntryView: View {
    @ObservedObject private var leaderboardManager = LeaderboardManager.shared
    @State var entry: LeaderboardEntry
    
    var body: some View {
        HStack {
            ZStack {
                CachedAsyncImage(url: getAvatarURL()) { image in
                    image
                } placeholder: {
                    Image("steve_avatar")
                }
                .frame(width: 32)
                .padding(.leading, 10)
                .shadow(color: getColor().opacity(0.5), radius: 10)
                
                LeaderboardEntryRank(placement: $entry.position)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(y: -5)
            }
            .frame(width: 42)
            
            VStack(spacing: 3) {
                HStack {
                    Text(entry.name)
                        .minecraftFont()
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(entry.date)
                        .minecraftFont()
                }
                .applyThemeText()
                
                HStack {
                    Text(entry.igt)
                        .minecraftFont()
                        .applyThemeText()
                    
                    Spacer()
                    
                    Text(entry.verification.label.localized)
                        .minecraftFont()
                        .foregroundStyle(getVerificationColor())
                }
            }
        }
        .frame(height: 32)
    }
    
    private func getAvatarURL() -> URL? {
        let name = leaderboardManager.nicknames[entry.name] ?? entry.name
        return URL(string: "https://minotar.net/helm/\(name)/32")
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
                return ThemeManager.shared.text
        }
    }
    
    private func getColor() -> Color {
        switch entry.position {
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
    LeaderboardEntryView(entry: LeaderboardEntry(position: 0, name: "Feinberg", igt: "2:25:30", date: "23 August 2023", verification: .verified))
        .frame(width: 196)
        .padding()
}
