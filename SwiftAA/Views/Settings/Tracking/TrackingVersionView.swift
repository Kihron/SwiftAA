//
//  TrackingVersionView.swift
//  SwiftAA
//
//  Created by Kihron on 2/7/24.
//

import SwiftUI

struct TrackingVersionView: View {
    @ObservedObject private var trackerManager = TrackerManager.shared
    @ObservedObject private var dataManager = DataManager.shared
    
    private var availableStyles: [LayoutStyle] {
        return LayoutStyle.getAvailableStyles(version: trackerManager.gameVersion)
    }
    
    var body: some View {
        SettingsCardView {
            VStack {
                SettingsPickerView(title: L10n.Tracking.gameVersion, width: 75, selection: $trackerManager.gameVersion)
                
                if availableStyles.count > 1 {
                    Divider()
                    
                    SettingsPickerView(title: L10n.Tracking.viewStyle, description: L10n.Tracking.ViewStyle.info, width: 110, selection: $trackerManager.layoutStyle)
                }
            }
        }
    }
}

#Preview {
    TrackingVersionView()
        .padding()
}
