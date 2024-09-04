//
//  LeaderboardManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/16/23.
//

import SwiftUI

class LeaderboardManager: ObservableObject {
    private var networkManager = NetworkManager.shared
    
    @Published var entries: [LeaderboardEntry] = []
    
    private var otherVersionData: [String] = []
    private var v16Data: [String] = []
    var nicknames: [String:String] = [:]
    
    static let shared = LeaderboardManager()
    
    init() {
        loadSavedData()
        
        Task {
            await fetchAllLeaderboardData()
            getLeaderboardEntries()
        }
    }
    
    func getLeaderboardEntries() {
        switch TrackerManager.shared.gameVersion {
            case .v1_16, .v1_16_5:
                getV16Entries()
            case .v1_19:
                getEntriesForOtherVersions(version: .v1_19)
            case .v1_20:
                getEntriesForOtherVersions(version: .v1_20)
        }
    }
    
    private func saveData() {
        UserDefaults.standard.set(nicknames, forKey: "nicknames")
        UserDefaults.standard.set(v16Data, forKey: "v16Data")
        UserDefaults.standard.set(otherVersionData, forKey: "otherVersionData")
    }
    
    private func loadSavedData() {
        nicknames = UserDefaults.standard.dictionary(forKey: "nicknames") as? [String: String] ?? [:]
        v16Data = UserDefaults.standard.stringArray(forKey: "v16Data") ?? []
        otherVersionData = UserDefaults.standard.stringArray(forKey: "otherVersionData") ?? []
        
        getLeaderboardEntries()
    }
    
    private func fetchAllLeaderboardData() async {
        async let fetchNicknamesTask: () = fetchNicknames()
        async let fetchV16DataTask: () = fetchV16Data()
        async let fetchOtherVersionDataTask: () =  fetchOtherVersionData()
        
        await fetchNicknamesTask
        await fetchV16DataTask
        await fetchOtherVersionDataTask
        
        saveData()
    }
    
    private func fetchV16Data() async {
        if let url = URL(string: getSpreadsheet(page: "1706556435")) {
            if let raw = await networkManager.getRawData(url: url) {
                v16Data = Array(raw.components(separatedBy: "\n").dropFirst(2))
            }
        }
    }
    
    private func fetchOtherVersionData() async {
        if let url = URL(string: getSpreadsheet(page: "1283472797")) {
            if let raw = await networkManager.getRawData(url: url) {
                self.otherVersionData = raw.components(separatedBy: "\n")
            }
        }
    }
    
    private func updateEntries(newEntries: [LeaderboardEntry]) {
        if !newEntries.isEmpty && entries != newEntries {
            Task { @MainActor in
                entries.removeAll()
                entries = newEntries
            }
        }
    }
    
    private func getV16Entries() {
        let newEntries = v16Data.compactMap({ createEntry(from: $0) })
        updateEntries(newEntries: newEntries)
    }
    
    private func getEntriesForOtherVersions(version: Version) {
        if let versions = otherVersionData.first?.components(separatedBy: ","), let index = versions.firstIndex(of: "\(version.label) RSG") {
            let newEntries = otherVersionData.dropFirst(2).compactMap({ createEntry(from: $0, index: index) }).filter({ !$0.name.isEmpty })
            updateEntries(newEntries: newEntries)
        }
    }
    
    private func createEntry(from rawData: String, index: Int? = nil) -> LeaderboardEntry? {
        let components = rawData.components(separatedBy: ",")
        
        if let index = index {
            // Handle other versions
            guard components.count > index + 3 else { return nil }
            return LeaderboardEntry(
                position: Int(components[index]) ?? 0,
                name: components[index + 2],
                igt: components[index + 3],
                date: components[index + 1],
                verification: .unknown
            )
        } else {
            // Handle v16 data
            guard components.count > 4 else { return nil }
            return LeaderboardEntry(
                position: Int(components[0]) ?? 0,
                name: components[2],
                igt: components[3],
                date: components[1],
                verification: getVerificationStatus(status: components[4])
            )
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
    
    private func fetchNicknames() async {
        if let url = URL(string: "https://docs.google.com/spreadsheets/d/16VS6VkitZdyrfVAFd-UdkVSrXO0nhdMyNeueIFoqvZY/export?gid=0&format=csv") {
            if let raw = await networkManager.getRawData(url: url) {
                let lines = raw.components(separatedBy: "\n").dropFirst(2)
                
                self.nicknames = lines.map({ $0.components(separatedBy: ",") }).reduce(into: [String:String]()) {
                    $0[$1[0]] = $1[2].trimmingCharacters(in: .newlines).replacingOccurrences(of: "-", with: "")
                }
            }
        }
    }
    
    private func getSpreadsheet(page: String) -> String {
        return "https://docs.google.com/spreadsheets/d/107ijqjELTQQ29KW4phUmtvYFTX9-pfHsjb18TKoWACk/export?gid=\(page)&format=csv"
    }
}
