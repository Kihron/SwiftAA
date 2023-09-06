//
//  NewTrackingSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI

struct NewTrackingSettingsView: View {
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
            
            Text("Mode")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
            
            Text("Switch between automatic window tracking or manually specifying a saves directory.")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)

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
        .padding([.horizontal, .top])
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    NewTrackingSettingsView()
        .frame(width: 400, height: 500)
}
