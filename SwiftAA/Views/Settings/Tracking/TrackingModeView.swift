//
//  TrackingModeView.swift
//  SwiftAA
//
//  Created by Kihron on 2/7/24.
//

import SwiftUI

struct TrackingModeView: View {
    @AppSettings(\.tracker) private var settings
    
    var body: some View {
        VStack(spacing: 12) {
            SettingsLabel(title: L10n.Tracking.mode, description: L10n.Tracking.Mode.info)
            
            SettingsCardView {
                VStack {
                    HStack {
                        Picker("", selection: $settings.trackingMode) {
                            ForEach(TrackingMode.allCases, id: \.self) { item in
                                Text(item.label.localized)
                            }
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                    }
                    
                    Divider()
                    
                    if settings.trackingMode == .seamless {
                        SettingsToggleView(title: L10n.Tracking.Mode.automaticVersionDetection, description: L10n.Tracking.Mode.AutomaticVersionDetection.info, option: $settings.automaticVersionDetection)
                    } else {
                        HStack {
                            TextField("", text: $settings.customSavesPath)
                                .textFieldStyle(.roundedBorder)
                                .autocorrectionDisabled()
                            
                            Button(action: Utilities.selectSavesFolder) {
                                Text(L10n.Tracking.browse)
                            }
                        }
                    }
                }
            }
        }
        .animation(.bouncy, value: settings.trackingMode)
        .onChange(of: settings.trackingMode) { _ in
            withAnimation {
//                trackerManager.resetWorldPath()
            }
        }
    }
}

#Preview {
    TrackingModeView()
        .padding()
}
