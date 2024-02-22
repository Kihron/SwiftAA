//
//  LeaderboardPanelView.swift
//  SwiftAA
//
//  Created by Kihron on 9/16/23.
//

import SwiftUI

struct LeaderboardPanelView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @ObservedObject private var trackerManager = TrackerManager.shared
    @ObservedObject private var leaderboardManager = LeaderboardManager.shared
    
    private let placeholderUsers = 8
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(.clear)
                    .border(themeManager.border, width: 2)
                
                Text(L10n.Leaderboard.title)
                    .minecraftFont(size: 18)
                    .applyThemeText()
            }
            .frame(height: 48)
            .padding(8)
            
            Divider()
                .frame(height: 2)
                .overlay(themeManager.border)
            
            ZStack {
                if leaderboardManager.entries.isEmpty {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(0..<max(0, placeholderUsers), id: \.self) { idx in
                                LeaderboardPlaceholderView(placement: idx + 1)
                                    .padding(.bottom, 10)
                                    .padding(.top, 14)
                                
                                Divider()
                                    .frame(height: 2)
                                    .overlay(themeManager.border)
                                    .opacity(idx < max(0, placeholderUsers) - 1 ? 1 : 0)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                } else {
                    ScrollView(.vertical) {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(leaderboardManager.entries, id: \.id) { entry in
                                LeaderboardEntryView(entry: entry)
                                    .padding(.bottom, 10)
                                    .padding(.top, 14)
                                
                                Divider()
                                    .frame(height: 2)
                                    .overlay(themeManager.border)
                                    .opacity(entry.position < max(leaderboardManager.entries.count, 8) ? 1 : 0)
                            }
                            
                            ForEach(0..<max(0, placeholderUsers - leaderboardManager.entries.count), id: \.self) { idx in
                                LeaderboardPlaceholderView(placement: leaderboardManager.entries.count + idx + 1)
                                    .padding(.bottom, 10)
                                    .padding(.top, 14)
                                
                                Divider()
                                    .frame(height: 2)
                                    .overlay(themeManager.border)
                                    .opacity(idx < max(0, placeholderUsers - leaderboardManager.entries.count) - 1 ? 1 : 0)
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                    .animation(.bouncy, value: leaderboardManager.entries)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .applyThemeBackgroundAndBorder()
        .onChange(of: trackerManager.gameVersion) { value in
            leaderboardManager.getLeaderboardEntries()
        }
    }
}

#Preview {
    LeaderboardPanelView()
        .frame(width: 196, height: 364)
        .padding()
}
