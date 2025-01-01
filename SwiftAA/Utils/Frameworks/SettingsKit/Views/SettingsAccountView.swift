//
//  SettingsAccountView.swift
//  SwiftAA
//
//  Created by Kihron on 10/25/23.
//

import SwiftUI
import CachedAsyncImage

struct SettingsAccountView: View {
    @Access(\.playerManager) private var playerManager
    @AppSettings(\.tracker.player) private var player

    var body: some View {
        if let player = player {
            ZStack {
                Rectangle()
                    .fill(.gray.opacity(0.05))
                
                VStack {
                    Divider()
                    
                    HStack(alignment: .center) {
                        CachedAsyncImage(url: playerManager.getActivePlayerImageURL(), urlCache: .imageCache) { phase in
                            switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.interpolation(.none)
                                        .resizable()
                                        .frame(width: 26, height: 26)
                                case .failure:
                                    Image("steve")
                                        .interpolation(.none)
                                        .resizable()
                                        .frame(width: 26, height: 26)
                                @unknown default:
                                    EmptyView()
                            }
                        }
                        
                        Text(player.name)
                            .contentTransition(.numericText())
                            .animation(.smooth, value: player)
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
