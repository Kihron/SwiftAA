//
//  L1_16.swift
//  SwiftAA
//
//  Created by Kihron on 8/22/22.
//

import SwiftUI

struct L1_16: View {
    @ObservedObject private var trackerManager = TrackerManager.shared
    @State private var prevVersion: Version = .v1_19
    var body: some View {
        if [.v1_16, .v1_16_5].contains(trackerManager.gameVersion) {
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
}

#Preview {
    L1_16()
}
