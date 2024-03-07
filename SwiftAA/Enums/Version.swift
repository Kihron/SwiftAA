//
//  Version.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI

enum Version: String, SettingsOption {
    case v1_16 = "1.16"
    case v1_19 = "1.19"
    case v1_20 = "1.20"
    
    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
}
