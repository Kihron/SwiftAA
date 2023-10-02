//
//  TrackingSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI

struct TrackingSettingsView: View {
    @ObservedObject private var viewModel = TrackingSettingsViewModel()
    @ObservedObject private var trackerManager = TrackerManager.shared
    @ObservedObject private var dataManager = DataManager.shared
    
    var body: some View {
        VStack {
            SettingsCardView {
                VStack {
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
                        .onChange(of: trackerManager.gameVersion) { _ in
                            if trackerManager.layoutStyle == .minimalist {
                                dataManager.loadAllAdvancements()
                            }
                        }
                    }
                    
                    let availableStyles = LayoutStyle.getAvailableStyles(version: trackerManager.gameVersion)
                    
                    if availableStyles.count > 1 {
                        Divider()
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("View Style")
                                
                                Text("Standard shows all advancements horizontally. Both Vertical and Minimalistic remove redundant advancements.")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Picker("", selection: $trackerManager.layoutStyle) {
                                ForEach(availableStyles, id: \.self) { item in
                                    Text(item.label.localized)
                                }
                            }
                            .frame(maxWidth: 110)
                            .labelsHidden()
                            .onChange(of: trackerManager.layoutStyle) { layout in
                                dataManager.map.removeAll()
                                
                                if layout == .minimalist {
                                    dataManager.loadAllAdvancements()
                                }
                            }
                        }
                    }
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
