//
//  ToolbarPlayerHead.swift
//  SwiftAA
//
//  Created by Kihron on 8/18/22.
//

import SwiftUI
import CachedAsyncImage

struct ToolbarPlayerHead: View {
    @Access(\.trackerEngine) private var trackerEngine
    @Access(\.playerManager) private var playerManager

    @AppSettings(\.player.player) private var player

    @State private var showPlayerList: Bool = false

    var body: some View {
        Button(action: { showPlayerList.toggle() }) {
            VStack {
                CachedAsyncImage(url: playerManager.getActivePlayerImageURL(), urlCache: .imageCache) { phase in
                    switch phase {
                        case .empty:
                            Image("steve")
                                .resizable()
                                .interpolation(.none)
                                .frame(width: 32, height: 32)
                        case .success(let image):
                            image
                                .resizable()
                                .interpolation(.none)
                                .frame(width: 32, height: 32)
                        case .failure:
                            Image("steve")
                                .resizable()
                                .interpolation(.none)
                                .frame(width: 32, height: 32)
                        @unknown default:
                            EmptyView()
                    }
                }
            }
        }
        .buttonStyle(.plain)
        .allowsHitTesting(playerManager.availablePlayers.count > 1)
        .animation(.easeInOut, value: player)
        .popover(isPresented: $showPlayerList) {
            availablePlayers
        }
    }

    @ViewBuilder var availablePlayers: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(playerManager.availablePlayers, id: \.self) { player in
                    Button(action: {
                        playerManager.updatePlayer(to: player, shouldRefreshTracker: true)
                        showPlayerList.toggle()
                    }) {
                        HStack {
                            CachedAsyncImage(url: playerManager.getPlayerImageURL(for: player), urlCache: .imageCache) { phase in
                                switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .interpolation(.none)
                                            .frame(width: 32, height: 32)
                                    case .failure:
                                        Image("steve")
                                            .resizable()
                                            .interpolation(.none)
                                            .frame(width: 32, height: 32)
                                    @unknown default:
                                        EmptyView()
                                }
                            }

                            Text(player)
                                .lineLimit(1)
                        }
                        .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(12)
        }
        .frame(width: 135)
        .frame(maxHeight: 300)
        .scrollIndicators(.hidden)
    }
}

struct ToolbarPlayerHead_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarPlayerHead()
    }
}
