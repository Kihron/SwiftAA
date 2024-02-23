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
                        .onChange(of: trackerManager.trackingMode) { _ in
                            if trackerManager.layoutStyle != .standard {
                                dataManager.minimalCache = nil
                            }
                        }
                    }
                    
                    Divider()
                    
                    if trackerManager.trackingMode == .seamless {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text(L10n.Tracking.Mode.automaticVersionDetection)
                                
                                Text(L10n.Tracking.Mode.AutomaticVersionDetection.info)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Toggle("", isOn: $trackerManager.automaticVersionDetection)
                                .labelsHidden()
                                .toggleStyle(.switch)
                        }
                    } else {
                        HStack {
                            TextField("", text: $trackerManager.customSavesPath)
                                .textFieldStyle(.roundedBorder)
                                .autocorrectionDisabled()
                            
                            Button(action: { Utilities.selectSavesFolder() }) {
                                Text(L10n.Tracking.browse)
                            }
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: trackerManager.trackingMode)
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
