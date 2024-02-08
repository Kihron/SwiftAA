//
//  LeaderboardManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/16/23.
//

import SwiftUI

class LeaderboardManager: ObservableObject {
    @ObservedObject private var networkManager = NetworkManager.shared
    @Published var entries: [LeaderboardEntry] = []
    
    private var otherVersionData: [String] = []
    var nicknames: [String:String] = [:]
    
    static let shared = LeaderboardManager()
    
    init() {
        Task {
            await fetchNicknames()
            await fetchOtherVersionData()
            await getLeaderboardEntries()
        }
    }
    
    func getLeaderboardEntries() async {
        entries.removeAll()
        switch TrackerManager.shared.gameVersion {
            case .v1_16:
                await getV16()
            case .v1_19:
                getEntriesForOtherVersions(version: .v1_19)
            case .v1_20:
                getEntriesForOtherVersions(version: .v1_20)
        }
    }
    
    private func getV16() async {
        if let url = URL(string: getSpreadsheet(page: "1706556435")) {
            if let raw = await networkManager.getRawData(url: url) {
                let lines = raw.components(separatedBy: "\n").dropFirst(2)
                
                DispatchQueue.main.async {
                    withAnimation {
                        self.entries = lines.map({ $0.components(separatedBy: ",") }).map({ LeaderboardEntry(position: Int($0[0]) ?? 0, name: $0[2], igt: $0[3], date: $0[1], verification: self.getVerificationStatus(status: $0[4])) })
                    }
                }
            }
        }
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
    
    private func getEntriesForOtherVersions(version: Version) {
        let versions = otherVersionData.map({ $0.components(separatedBy: ",") })[0]
        if let index = versions.firstIndex(of: "\(version.label) RSG") {
            withAnimation {
                self.entries = otherVersionData.dropFirst(2).map({ $0.components(separatedBy: ",") }).map({ LeaderboardEntry(position: Int($0[index]) ?? 0, name: $0[index+2], igt: $0[index+3], date: $0[index+1], verification: .unknown) }).filter({ !$0.name.isEmpty })
            }
        }
    }
    
    func fetchOtherVersionData() async {
        if let url = URL(string: getSpreadsheet(page: "1283472797")) {
            if let raw = await networkManager.getRawData(url: url) {
                self.otherVersionData = raw.components(separatedBy: "\n")
            }
        }
    }
    
    func fetchNicknames() async {
        if let url = URL(string: "https://docs.google.com/spreadsheets/d/16VS6VkitZdyrfVAFd-UdkVSrXO0nhdMyNeueIFoqvZY/export?gid=0&format=csv") {
            if let raw = await networkManager.getRawData(url: url) {
                let lines = raw.components(separatedBy: "\n").dropFirst(2)
                
                self.nicknames = lines.map({ $0.components(separatedBy: ",") }).reduce(into: [String:String]()) {
                    $0[$1[0]] = $1[2].trimmingCharacters(in: .newlines)
                }
            }
        }
    }
    
    private func getSpreadsheet(page: String) -> String {
        return "https://docs.google.com/spreadsheets/d/107ijqjELTQQ29KW4phUmtvYFTX9-pfHsjb18TKoWACk/export?gid=\(page)&format=csv"
    }
}
