//
//  SettingsAccountView.swift
//  SwiftAA
//
//  Created by Kihron on 10/25/23.
//

import SwiftUI
import CachedAsyncImage

struct SettingsAccountView: View {
    @ObservedObject private var playerManager = PlayerManager.shared
    
    var body: some View {
        if let player = playerManager.player {
            ZStack {
                Rectangle()
                    .fill(.gray.opacity(0.05))
                
                VStack {
                    Divider()
                    
                    HStack(alignment: .center) {
                        if playerManager.playerHasLoaded {
                            CachedAsyncImage(url: playerManager.imageURL, urlCache: .imageCache) { phase in
                                switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.interpolation(.none)
                                            .resizable()
                                            .frame(width: 26, height: 26)
                                    case .failure:
                                        EmptyView()
                                    @unknown default:
                                        EmptyView()
                                }
                            }
                        } else {
                            Image("steve")
                                .interpolation(.none)
                                .resizable()
                                .frame(width: 26, height: 26)
                        }
                        
                        Text(player.name)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.leading, 17)
                }
            }
            .frame(height: 42)
        }
    }
}

#Preview {
    SettingsAccountView()
        .padding()
}
