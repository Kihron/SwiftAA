//
//  ToolbarPlayerHead.swift
//  SwiftAA
//
//  Created by Kihron on 8/18/22.
//

import SwiftUI
import CachedAsyncImage

struct ToolbarPlayerHead: View {
    @ObservedObject private var playerManager = PlayerManager.shared
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
        .animation(.easeInOut, value: playerManager.player)
        .popover(isPresented: $showPlayerList) {
            availablePlayers
        }
    }

    @ViewBuilder var availablePlayers: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(playerManager.availablePlayers, id: \.self) { player in
                    Button(action: {
                        playerManager.updatePlayerUUID(uuid: player)
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
