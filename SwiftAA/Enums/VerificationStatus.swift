//
//  VerificationStatus.swift
//  SwiftAA
//
//  Created by Kihron on 9/16/23.
//

import SwiftUI

enum VerificationStatus: String, CaseIterable, Identifiable, Hashable {
    case verified = "leaderboard.verified"
    case awaitingVerification = "leaderboard.awaiting_verification"
    case notSubmitted = "leaderboard.not_submitted"
    case unknown = "leaderboard.unknown"
    
    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
}
