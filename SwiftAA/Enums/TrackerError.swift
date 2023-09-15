//
//  TrackerError.swift
//  SwiftAA
//
//  Created by Kihron on 9/14/23.
//

import SwiftUI

enum TrackerError: Error, CaseIterable, Identifiable, Hashable {
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
                "error.enter_minecraft"
            case .invalidDirectory:
                "error.invalid_directory"
            case .directoryNotFound:
                "error.directory_not_found"
            case .noDirectory:
                "error.no_directory"
            case .noWorlds:
                "error.no_worlds"
        }
    }
}
