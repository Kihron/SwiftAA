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
        VStack {
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
                        .onChange(of: trackerManager.trackingMode) { _ in
                            if trackerManager.layoutStyle != .standard {
                                dataManager.minimalCache = nil
                            }
                        }
                    }
                    
                    HStack {
                        TextField("", text: $trackerManager.customSavesPath)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                        
                        Button(action: { Utilities.selectSavesFolder() }) {
                            Text(L10n.Tracking.browse)
                        }
                    }
                    .disabled(trackerManager.trackingMode == .seamless)
                }
            }
        }
        .onChange(of: trackerManager.trackingMode) { _ in
            withAnimation {
                trackerManager.resetWorldPath()
            }
        }
    }
}

#Preview {
    TrackingModeView()
}
