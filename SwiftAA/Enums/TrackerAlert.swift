//
//  TrackerAlert.swift
//  SwiftAA
//
//  Created by Kihron on 9/14/23.
//

import SwiftUI

enum TrackerAlert: Error, CaseIterable, Identifiable, Hashable {
    case enterMinecraft
    case invalidDirectory
    case directoryNotFound
    case noDirectory
    case noWorlds
    
    var id: UUID {
        return UUID()
    }
    
    var description: String {
        switch self {
            case .enterMinecraft:
                "alert.enter_minecraft"
            case .invalidDirectory:
                "alert.invalid_directory"
            case .directoryNotFound:
                "alert.directory_not_found"
            case .noDirectory:
                "alert.no_directory"
            case .noWorlds:
                "alert.no_worlds"
        }
    }
}
