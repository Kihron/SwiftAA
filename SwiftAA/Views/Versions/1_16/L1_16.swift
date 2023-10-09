//
//  L1_16.swift
//  SwiftAA
//
//  Created by Kihron on 8/22/22.
//

import SwiftUI

struct L1_16: View {
    @ObservedObject private var trackerManager = TrackerManager.shared
    
    var body: some View {
        switch trackerManager.layoutStyle {
            case .standard:
                L1_16S()
            case .vertical:
                L1_16V()
            case .minimalist:
                L1_16M()
        }
    }
}

#Preview {
    L1_16()
}
