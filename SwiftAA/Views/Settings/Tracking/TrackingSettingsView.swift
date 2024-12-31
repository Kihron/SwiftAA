//
//  TrackingSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI

struct TrackingSettingsView: View {
    @AppSettings(\.tracker) private var settings

    private var availableStyles: [LayoutStyle] {
        return LayoutStyle.getAvailableStyles(version: settings.gameVersion)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            SettingsCardView {
                VStack {
                    SettingsPickerView(title: L10n.Tracking.gameVersion, width: 75, selection: $settings.gameVersion)
                        .disabled(settings.automaticVersionDetection && settings.trackingMode == .seamless)

                    Group {
                        if availableStyles.count > 1 {
                            Divider()
                            
                            SettingsPickerView(title: L10n.Tracking.viewStyle, description: L10n.Tracking.ViewStyle.info, width: 110, selection: $settings.layoutStyle, filter: availableStyles)
                        }
                    }
                    .disabled(availableStyles.count <= 1)
                }
            }
            
            SettingsCardView {
                SettingsToggleView(title: L10n.Tracking.automaticExpansion, description: L10n.Tracking.AutomaticExpansion.info, option: $settings.automaticExpansion)
            }
            
            TrackingModeView()
                .padding(.top, 5)
        }
        .padding([.horizontal, .top])
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .animation(.bouncy.delay(0.4), value: availableStyles)
    }
}

#Preview {
    TrackingSettingsView()
        .frame(width: 600, height: 500)
}
