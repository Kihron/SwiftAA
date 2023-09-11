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
    
    var body: some View {
        if playerManager.playerHasLoaded {
            CachedAsyncImage(url: playerManager.imageURL) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                    image.interpolation(.none)
                        .resizable()
                        .frame(width: 32, height: 32)
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
                .frame(width: 32, height: 32)
        }
    }
}

struct ToolbarPlayerHead_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarPlayerHead()
    }
}
