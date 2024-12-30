//
//  TrackingMode.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI

enum TrackingMode: String, CaseIterable, Identifiable, Hashable, Codable {
    case seamless = "tracking.seamless"
    case directory = "tracking.custom_saves"
    
    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
}
