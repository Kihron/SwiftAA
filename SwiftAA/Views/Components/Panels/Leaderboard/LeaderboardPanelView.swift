//
//  LeaderboardPanelView.swift
//  SwiftAA
//
//  Created by Kihron on 9/16/23.
//

import SwiftUI

struct LeaderboardPanelView: View {
    @ObservedObject private var themeManager = UIThemeManager.shared
    @ObservedObject private var trackerManager = TrackerManager.shared
    @ObservedObject private var leaderboardManager = LeaderboardManager.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(.clear)
                    .border(themeManager.border, width: 2)
                
                Text("MCSR Community")
                    .font(.custom("Minecraft-Regular", size: 18))
                    .applyThemeText()
            }
            .frame(height: 48)
            .padding(8)
            
            Divider()
                .frame(height: 2)
                .overlay(themeManager.border)
            
            if leaderboardManager.entries.isEmpty {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                ScrollView(.vertical) {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(leaderboardManager.entries.indices, id: \.self) { idx in
                            let entry = leaderboardManager.entries[idx]
                            LeaderboardEntryView(entry: entry, placement: idx)
                                .padding(.bottom, 10)
                                .padding(.top, 14)
                            
                            if idx < leaderboardManager.entries.count - 1 {
                                Divider()
                                    .frame(height: 2)
                                    .overlay(themeManager.border)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                }
                .animation(.bouncy, value: leaderboardManager.entries)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .applyThemeBackgroundAndBorder()
        .task {
            await leaderboardManager.getLeaderboardEntries()
        }
        .onChange(of: trackerManager.gameVersion) { _ in
            Task {
                await leaderboardManager.getLeaderboardEntries()
            }
        }
    }
}

#Preview {
    LeaderboardPanelView()
        .frame(width: 196)
        .padding()
}
