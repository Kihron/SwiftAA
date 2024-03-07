//
//  ImageCache.swift
//  SwiftAA
//
//  Created by Kihron on 2/20/24.
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
