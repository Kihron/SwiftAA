//
//  OverlaySettings.swift
//  SwiftAA
//
//  Created by Kihron on 9/8/23.
//

import SwiftUI

struct OverlaySettings: View {
    @ObservedObject private var overlayManager = OverlayManager.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                SettingsCardView {
                    VStack {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text(L10n.Overlay.Style.title)
                                
                                Text(L10n.Overlay.Style.description)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Picker("", selection: $overlayManager.overlayStyle) {
                                ForEach(OverlayStyle.allCases, id: \.self) { item in
                                    Text(item.label.localized)
                                }
                            }
                            .frame(maxWidth: 105)
                            .labelsHidden()
                        }
                        
                        if case .multiPage = overlayManager.overlayStyle {
                            Divider()
                            
                            HStack {
                                Text("Show Page Indicator")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Toggle("", isOn: $overlayManager.showLegacyPageIndicator)
                                    .labelsHidden()
                                    .toggleStyle(.switch)
                            }
                        }
                    }
                }
                
                SettingsCardView {
                    VStack {
                        HStack {
                            Text(L10n.Overlay.showstats)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Toggle("", isOn: $overlayManager.showStatistics)
                                .labelsHidden()
                                .toggleStyle(.switch)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text(L10n.Settings.Alignment.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Picker("", selection: $overlayManager.statisticsAlignment) {
                                ForEach(HAlignment.allCases, id: \.self) { item in
                                    Text(item.label.localized)
                                }
                            }
                            .frame(maxWidth: 75)
                            .labelsHidden()
                        }
                        .disabled(!overlayManager.showStatistics)
                    }
                }
                
                SettingsCardView {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Clarify Ambigious Criteria")
                            
                            Text("Displays the advancement a criteria belongs to if it's icon is used more than once.")
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .padding(.trailing, 2)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Toggle("", isOn: $overlayManager.clarifyAmbigiousCriteria)
                            .labelsHidden()
                            .toggleStyle(.switch)
                    }
                }
                
                SettingsLabel(title: "Appearance", description: "Change the style of the frames, keep them in sync or mix and match.")
                    .padding(.top, 5)
                
                SettingsCardView {
                    VStack {
                        HStack {
                            Text("Sync Overlay")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Toggle("", isOn: $overlayManager.syncOverlayFrame)
                                .labelsHidden()
                                .toggleStyle(.switch)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Frame Style")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Picker("", selection: $overlayManager.overlayFrameStyle) {
                                ForEach(FrameStyle.allCases, id: \.self) { item in
                                    Text(item.label.localized)
                                }
                            }
                            .frame(maxWidth: 90)
                            .labelsHidden()
                        }
                        .disabled(overlayManager.syncOverlayFrame)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .animation(.bouncy, value: overlayManager.overlayStyle)
            .onChange(of: overlayManager.syncOverlayFrame) { value in
                if value {
                    overlayManager.overlayFrameStyle = LayoutManager.shared.frameStyle
                }
            }
            .padding()
        }
    }
}

#Preview {
    OverlaySettings()
        .padding()
}
