//
//  LeaderboardEntry.swift
//  SwiftAA
//
//  Created by Kihron on 9/16/23.
//

import SwiftUI

struct LeaderboardEntry: Identifiable, Hashable {
    let id = UUID()
    
    var position: Int
    var name: String
    var igt: String
    var date: String
    var verification: VerificationStatus
    
    static func == (lhs: LeaderboardEntry, rhs: LeaderboardEntry) -> Bool {
        return lhs.position == rhs.position &&
        lhs.name == rhs.name &&
        lhs.igt == rhs.igt &&
        lhs.date == rhs.date &&
        lhs.verification == rhs.verification
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(position)
        hasher.combine(name)
        hasher.combine(igt)
        hasher.combine(date)
        hasher.combine(verification)
    }
}
