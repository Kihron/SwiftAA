//
//  L1_20.swift
//  SwiftAA
//
//  Created by Kihron on 2/7/24.
//

import SwiftUI

struct L1_20: View {
    @AppSettings(\.tracker) private var settings

    var body: some View {
        if settings.gameVersion == .v1_20 {
            switch settings.layoutStyle {
                case .standard:
                    L1_20S()
                case .vertical:
                    L1_20V()
                case .minimalist:
                    L1_20M()
            }
        }
    }
}

#Preview {
    L1_20()
}
