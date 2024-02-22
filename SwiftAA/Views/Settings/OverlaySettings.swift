//
//  OverlaySettings.swift
//  SwiftAA
//
//  Created by Kihron on 9/8/23.
//

import SwiftUI

struct OverlaySettings: View {
    @ObservedObject private var overlayManager = OverlayManager.shared
    @State private var showStatusEditor: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                SettingsCardView {
                    VStack {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text(L10n.Overlay.Style.title)
                                
                                Text(LocalizedStringKey(L10n.Overlay.Style.description))
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
                                Text(L10n.Overlay.Appearance.showLegacyPageBar)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Toggle("", isOn: $overlayManager.showLegacyPageIndicator)
                                    .labelsHidden()
                                    .toggleStyle(.switch)
                            }
                        }
                        
                        if case .optimal = overlayManager.overlayStyle {
                            Divider()
                            
                            HStack {
                                Text(L10n.Overlay.Appearance.showProgressBar)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Toggle("", isOn: $overlayManager.showOptimalProgressBar)
                                    .labelsHidden()
                                    .toggleStyle(.switch)
                            }
                        }
                    }
                }
                
                SettingsCardView {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(L10n.Overlay.Appearance.showTime)
                            
                            Text(L10n.Overlay.Appearance.ShowTime.info)
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .padding(.trailing, 2)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Toggle("", isOn: $overlayManager.showInGameTime)
                            .labelsHidden()
                            .toggleStyle(.switch)
                    }
                }
                
                SettingsCardView {
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 3) {
                                Text(L10n.Overlay.Appearance.showStatistics)
                                
                                Text(L10n.Overlay.Appearance.ShowStatistics.info)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Toggle("", isOn: $overlayManager.showStatistics)
                                .labelsHidden()
                                .toggleStyle(.switch)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text(L10n.Overlay.Appearance.statisticsRow)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button(action: { showStatusEditor.toggle() }) {
                                Text(L10n.Overlay.Appearance.StatisticsRow.button)
                            }
                        }
                        .disabled(!overlayManager.showStatistics)
                        
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
                            Text(L10n.Overlay.Appearance.clarifyAmbiguousCriteria)
                            
                            Text(L10n.Overlay.Appearance.ClarifyAmbiguousCriteria.info)
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
                
                SettingsLabel(title: L10n.Overlay.Appearance.title, description: L10n.Overlay.Appearance.info)
                    .padding(.top, 5)
                
                SettingsCardView {
                    VStack {
                        HStack {
                            Text(L10n.Overlay.Appearance.syncOverlay)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Toggle("", isOn: $overlayManager.syncOverlayFrame)
                                .labelsHidden()
                                .toggleStyle(.switch)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text(L10n.Overlay.Appearance.frameStyle)
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
            .sheet(isPresented: $showStatusEditor, content: {
                StatusIndicatorPickerView(isSettings: true)
            })
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
