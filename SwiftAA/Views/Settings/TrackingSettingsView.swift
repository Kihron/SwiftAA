//
//  TrackingSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI

struct TrackingSettingsView: View {
    @ObservedObject var viewModel = TrackingSettingsViewModel()
    @ObservedObject var trackerManager = TrackerManager.shared
    
    var body: some View {
        VStack {
            SettingsCardView {
                HStack {
                    Text(L10n.Tracking.Game.version)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Picker("", selection: $trackerManager.gameVersion) {
                        ForEach(Version.allCases, id: \.self) { item in
                            Text(item.label)
                        }
                    }
                    .frame(maxWidth: 75)
                    .labelsHidden()
                }
            }
            
            SettingsLabel(title: "Mode", description: "Switch between automatic window tracking or manually specifying a saves directory.")
                .padding(.top, 5)

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
                    
                    HStack {
                        TextField("", text: $trackerManager.customSavesPath)
                            .autocorrectionDisabled()
                        
                        Button(action: { viewModel.openFinderWindow() }) {
                            Text(L10n.Tracking.browse)
                        }
                    }
                    .disabled(trackerManager.trackingMode == .seamless)
                }
            }
        }
        .onChange(of: trackerManager.trackingMode) { _ in
            trackerManager.resetWorldPath()
        }
        .padding([.horizontal, .top])
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    TrackingSettingsView()
        .frame(width: 400, height: 500)
}
