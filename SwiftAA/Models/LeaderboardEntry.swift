//
//  LeaderboardEntry.swift
//  SwiftAA
//
//  Created by Kihron on 9/16/23.
//

import SwiftUI

struct LeaderboardEntry: Identifiable, Hashable {
    let id = UUID()
    
    var name: String
    var igt: String
    var date: String
    var verification: VerificationStatus
}
