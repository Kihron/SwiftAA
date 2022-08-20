//
//  ToolbarPlayerHead.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 8/18/22.
//

import SwiftUI
import CachedAsyncImage

struct ToolbarPlayerHead: View {
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        if (settings.player != nil) {
            CachedAsyncImage(url: URL(string: "https://cravatar.eu/helmhead/\(settings.player!.id)/64.png")) { phase in
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
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        ToolbarPlayerHead()
            .environmentObject(settings)
    }
}
