//
//  NetworkManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/17/23.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "SwiftAA.NetworkMonitor")
    @Published private(set) var connected: Bool = false
    
    static let shared = NetworkManager()

    init() {
        checkConnection()
    }
    
    private func checkConnection() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                    self.connected = true
            } else {
                    self.connected = false
            }
        }
        monitor.start(queue: queue)
    }
    
    func getRawData(url: URL) async -> String? {
        do {
            let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            guard let hashedName = url.absoluteString.data(using: .utf8)?.base64EncodedString() else { return nil }
            let cacheFile = cacheDirectory.appendingPathComponent(hashedName)
            
            let (data, response): (Data, URLResponse)
            
            if connected {
                // Create a "HEAD" request to check the content size in the response headers
                var headRequest = URLRequest(url: url)
                headRequest.httpMethod = "HEAD"
                let (_, headResponse) = try await URLSession.shared.data(for: headRequest)
                
                if let cacheAttributes = try? FileManager.default.attributesOfItem(atPath: cacheFile.path),
                   let cacheSize = cacheAttributes[.size] as? NSNumber,
                   let serverSize = headResponse.expectedContentLength > -1 ? Int64(headResponse.expectedContentLength) as NSNumber : nil,
                   serverSize == cacheSize {
                    // If the cache file’s size matches the server’s file, load the cache
                    if let cachedData = try? Data(contentsOf: cacheFile) {
                        data = cachedData
                        response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
                    } else {
                        throw URLError(.cannotLoadFromNetwork)
                    }
                } else {
                    // download fresh data
                    let dataTaskRequest = URLRequest(url: url)
                    (data, response) = try await URLSession.shared.data(for: dataTaskRequest)

                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    
                    try data.write(to: cacheFile)
                }
            } else {
                // No network
                if FileManager.default.fileExists(atPath: cacheFile.path), let cachedData = try? Data(contentsOf: cacheFile) {
                    data = cachedData
                    response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
                } else {
                    throw URLError(.notConnectedToInternet)
                }
            }
            
            return String(data: data, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}