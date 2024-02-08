//
//  TrackingSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI

struct TrackingSettingsView: View {
    var body: some View {
        VStack {
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
        .frame(width: 400, height: 500)
}
