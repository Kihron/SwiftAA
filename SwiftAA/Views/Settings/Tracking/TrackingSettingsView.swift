//
//  TrackingSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI

struct TrackingSettingsView: View {
    var body: some View {
        VStack(spacing: 12) {
            TrackingVersionView()
                .padding(.bottom, 5)
            
            TrackingModeView()
        }
        .padding([.horizontal, .top])
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    TrackingSettingsView()
        .frame(width: 600, height: 500)
}
