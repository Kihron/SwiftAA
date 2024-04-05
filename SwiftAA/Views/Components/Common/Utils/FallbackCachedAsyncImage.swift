//
//  FallbackCachedAsyncImage.swift
//  SwiftAA
//
//  Created by Kihron on 4/4/24.
//

import SwiftUI
import CachedAsyncImage

struct FallbackCachedAsyncImage<Placeholder: View>: View {
    let urls: [URL?]
    let placeholder: () -> Placeholder
    @State private var currentIndex = 0
    
    private var currentURL: URL? {
        urls.indices.contains(currentIndex) ? urls[currentIndex] : nil
    }
    
    var body: some View {
        CachedAsyncImage(url: currentURL, urlCache: .imageCache) { phase in
            switch phase {
                case .empty:
                    placeholder()
                case .success(let image):
                    image
                case .failure:
                    if currentIndex < urls.count - 1 {
                        placeholder()
                            .onAppear {
                                currentIndex += 1
                            }
                    } else {
                        placeholder()
                    }
                @unknown default:
                    placeholder()
            }
        }
    }
}
