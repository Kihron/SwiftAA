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
                        SettingsPickerView(title: L10n.Overlay.Style.title, description: L10n.Overlay.Style.description, width: 105, selection: $overlayManager.overlayStyle)
                        
                        if case .multiPage = overlayManager.overlayStyle {
                            Divider()
                            
                            SettingsToggleView(title: L10n.Overlay.Appearance.showLegacyPageBar, option: $overlayManager.showLegacyPageIndicator)
                        }
                        
                        if case .optimal = overlayManager.overlayStyle {
                            Divider()
                            
                            SettingsToggleView(title: L10n.Overlay.Appearance.showProgressBar, option: $overlayManager.showOptimalProgressBar)
                        }
                    }
                }
                
                SettingsCardView {
                    SettingsToggleView(title: L10n.Overlay.Appearance.showTime, description: L10n.Overlay.Appearance.ShowTime.info, option: $overlayManager.showInGameTime)
                }
                
                SettingsCardView {
                    VStack {
                        SettingsToggleView(title: L10n.Overlay.Appearance.showStatistics, description: L10n.Overlay.Appearance.ShowStatistics.info, option: $overlayManager.showStatistics)
                        
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
                        
                        SettingsPickerView(title: L10n.Settings.Alignment.title, width: 75, selection: $overlayManager.statisticsAlignment)
                            .disabled(!overlayManager.showStatistics)
                    }
                }
                
                SettingsCardView {
                    SettingsToggleView(title: L10n.Overlay.Appearance.clarifyAmbiguousCriteria, description: L10n.Overlay.Appearance.ClarifyAmbiguousCriteria.info, option: $overlayManager.clarifyAmbigiousCriteria)
                }
                
                SettingsLabel(title: L10n.Overlay.Appearance.title, description: L10n.Overlay.Appearance.info)
                    .padding(.top, 5)
                
                SettingsCardView {
                    VStack {
                        SettingsToggleView(title: L10n.Overlay.Appearance.syncOverlay, option: $overlayManager.syncOverlayFrame)
                        
                        Divider()
                        
                        SettingsPickerView(title: L10n.Overlay.Appearance.frameStyle, width: 90, selection: $overlayManager.overlayFrameStyle)
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
