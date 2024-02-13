//
//  OverlayStyle.swift
//  SwiftAA
//
//  Created by Kihron on 9/10/23.
//

import SwiftUI

enum OverlayStyle: String, CaseIterable, Identifiable, Hashable {
    case optimal = "overlay.optimal"
    case tickerTape = "overlay.tickertape"
    case multiPage = "overlay.multipage"
    
    var id: Self {
        return self
    }
    
    var label: String {
        return rawValue
    }
}
