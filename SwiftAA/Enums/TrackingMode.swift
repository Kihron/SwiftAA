//
//  TrackingMode.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 9/5/23.
//

import SwiftUI

enum TrackingMode: String, CaseIterable, Identifiable, Hashable {
    case seamless = "tracking.seamless"
    case directory = "tracking.custom.saves"
    
    var id: UUID {
        return UUID()
    }
    
    var label: String {
        return rawValue
    }
}
