//
//  TrackingModeView.swift
//  SwiftAA
//
//  Created by Kihron on 2/7/24.
//

import SwiftUI

struct TrackingModeView: View {
    @ObservedObject private var trackerManager = TrackerManager.shared
    @ObservedObject private var dataManager = DataManager.shared
    
    var body: some View {
        VStack(spacing: 12) {
            SettingsLabel(title: L10n.Tracking.mode, description: L10n.Tracking.Mode.info)
            
            SettingsCardView {
                VStack {
                    HStack {
                        Picker("", selection: $trackerManager.trackingMode) {
                            ForEach(TrackingMode.allCases, id: \.self) { item in
                                Text(item.label.localized)
                            }
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                    }
                    
                    Divider()
                    
                    if trackerManager.trackingMode == .seamless {
                        SettingsToggleView(title: L10n.Tracking.Mode.automaticVersionDetection, description: L10n.Tracking.Mode.AutomaticVersionDetection.info, option: $trackerManager.automaticVersionDetection)
                    } else {
                        HStack {
                            TextField("", text: $trackerManager.customSavesPath)
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
        .animation(.bouncy, value: trackerManager.trackingMode)
        .onChange(of: trackerManager.trackingMode) { _ in
            withAnimation {
                trackerManager.resetWorldPath()
            }
        }
    }
}

#Preview {
    TrackingModeView()
        .padding()
}
