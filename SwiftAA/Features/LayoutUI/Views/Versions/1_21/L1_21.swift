//
//  L1_21.swift
//  SwiftAA
//
//  Created by Andrew on 12/28/24.
//

import SwiftUI

struct L1_21: View {
    @AppSettings(\.tracker) private var settings

    var body: some View {
        if [.v1_21, .v1_21_4].contains(settings.gameVersion) {
            switch settings.layoutStyle {
                case .standard:
                    L1_21S()
                case .vertical:
                    L1_21V()
                case .minimalist:
                    L1_21M()
            }
        }
    }
}

#Preview {
    L1_21()
}
