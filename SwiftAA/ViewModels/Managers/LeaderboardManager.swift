//
//  LeaderboardManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/16/23.
//

import SwiftUI

class LeaderboardManager: ObservableObject {
    @Published var entries: [LeaderboardEntry] = []
    
    static let shared = LeaderboardManager()
    
    init() {
        
    }
    
    func getLeaderboardEntries() async {
        //self.entries.removeAll()
        switch TrackerManager.shared.gameVersion {
            case .v1_16:
                await getV16()
            case .v1_19:
                await getV19()
        }
    }
    
    private func getV16() async {
        if let url = URL(string: getSpreadsheet(page: "1706556435")) {
            if let raw = await getRawData(url: url) {
                let lines = raw.components(separatedBy: "\n").dropFirst(2)
                
                DispatchQueue.main.async {
                    withAnimation {
                        self.entries = lines.map({ $0.components(separatedBy: ",") }).map({ LeaderboardEntry(name: $0[2], igt: $0[3], date: $0[1], verification: self.getVerificationStatus(status: $0[4])) })
                    }
                }
            }
        }
    }
    
    private func getRawData(url: URL) async -> String? {
        do {
            let urlSession = URLSession.shared
            let (data, response) = try await urlSession.data(from: url)
            
            if (response as! HTTPURLResponse).statusCode != 200 {
                return nil
            }
            
            return String(decoding: data, as: UTF8.self)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func getVerificationStatus(status: String) -> VerificationStatus {
        guard let first = status.first?.lowercased() else { return .unknown }
        switch first {
            case "a":
                return .awaitingVerification
            case "v":
                return .verified
            case "n":
                return .notSubmitted
            default:
                return .unknown
        }
    }
    
    private func getV19() async {
        //if let url = URL(string)
    }
    
    private func getSpreadsheet(page: String) -> String {
        return "https://docs.google.com/spreadsheets/d/107ijqjELTQQ29KW4phUmtvYFTX9-pfHsjb18TKoWACk/export?gid=\(page)&format=csv"
    }
}
