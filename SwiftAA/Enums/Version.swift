//
//  Version.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 9/5/23.
//

import SwiftUI

enum Version: String, CaseIterable, Identifiable, Hashable {
    case v1_16 = "1.16"
    case v1_19 = "1.19"
    
    var id: UUID {
        return UUID()
    }
    
    var label: String {
        return rawValue
    }
}