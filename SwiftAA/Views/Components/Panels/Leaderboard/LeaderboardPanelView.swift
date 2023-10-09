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
    
    let placeholderUsers = 8
    
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
            
            ZStack {
                if leaderboardManager.entries.isEmpty {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(1..<placeholderUsers + 1, id: \.self) { idx in
                                LeaderboardPlaceholderView(placement: idx)
                                    .padding(.bottom, 10)
                                    .padding(.top, 14)
                                
                                if idx < placeholderUsers {
                                    Divider()
                                        .frame(height: 2)
                                        .overlay(themeManager.border)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                } else {
                    ScrollView(.vertical) {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(leaderboardManager.entries.indices, id: \.self) { idx in
                                let entry = leaderboardManager.entries[idx]
                                LeaderboardEntryView(entry: entry)
                                    .padding(.bottom, 10)
                                    .padding(.top, 14)
                                
                                if entry.position < leaderboardManager.entries.count {
                                    Divider()
                                        .frame(height: 2)
                                        .overlay(themeManager.border)
                                }
                            }
                            
                            if leaderboardManager.entries.count < placeholderUsers {
                                ForEach(leaderboardManager.entries.count..<placeholderUsers, id: \.self) { idx in
                                    LeaderboardPlaceholderView(placement: idx + 1)
                                        .padding(.bottom, 10)
                                        .padding(.top, 14)
                                    
                                    if idx < placeholderUsers {
                                        Divider()
                                            .frame(height: 2)
                                            .overlay(themeManager.border)
                                    }
                                }
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
        .task {
            await leaderboardManager.fetchNicknames()
            await leaderboardManager.fetchOtherVersionData()
            await leaderboardManager.getLeaderboardEntries()
        }
        .onChange(of: trackerManager.gameVersion) { _ in
            leaderboardManager.entries.removeAll()
            Task {
                await leaderboardManager.getLeaderboardEntries()
            }
        }
    }
}

#Preview {
    LeaderboardPanelView()
        .frame(width: 196, height: 364)
        .padding()
}
