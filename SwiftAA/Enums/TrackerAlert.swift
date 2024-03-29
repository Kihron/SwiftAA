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
    case noFiles
    
    var id: Self {
        return self
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
            case .noFiles:
                "alert.no_files"
        }
    }
}
