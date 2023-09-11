//
//  OverlayStyle.swift
//  SwiftAA
//
//  Created by Kihron on 9/10/23.
//

import SwiftUI

enum OverlayStyle: String, CaseIterable, Identifiable, Hashable {
    case tickerTape = "overlay.tickertape"
    case multiPage = "overlay.multipage"
    
    var id: UUID {
        return UUID()
    }
    
    var label: String {
        return rawValue
    }
}
