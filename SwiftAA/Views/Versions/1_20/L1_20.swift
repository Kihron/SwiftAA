//
//  L1_20.swift
//  SwiftAA
//
//  Created by Kihron on 2/7/24.
//

import SwiftUI

struct L1_20: View {
    @ObservedObject private var trackerManager = TrackerManager.shared
    
    var body: some View {
        if trackerManager.gameVersion == .v1_20 {
            switch trackerManager.layoutStyle {
                case .standard:
                    L1_20S()
                default:
                    L1_20M()
            }
        }
    }
}

#Preview {
    L1_20()
}
