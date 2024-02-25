//
//  LayoutSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/18/23.
//

import SwiftUI

struct LayoutSettingsView: View {
    @ObservedObject private var layoutManager = LayoutManager.shared
    @ObservedObject private var trackerManager = TrackerManager.shared
    
    private var availableStyles: [LayoutStyle] {
        return LayoutStyle.getAvailableStyles(version: trackerManager.gameVersion)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            SettingsCardView {
                SettingsPickerView(title: L10n.Layout.modularPanel, description: L10n.Layout.ModularPanel.info, width: 110, selection: $layoutManager.modularPanel)
            }
            
            SettingsLabel(title: L10n.Layout.appearance)
                .padding(.top, 5)
            
            if availableStyles.count > 1 {
                SettingsCardView {
                    SettingsPickerView(title: L10n.Tracking.viewStyle, description: L10n.Tracking.ViewStyle.info, width: 110, selection: $trackerManager.layoutStyle, filter: availableStyles)
                }
            }
            
            SettingsCardView {
                VStack {
                    SettingsPickerView(title: L10n.Layout.Appearance.frameStyle, width: 90, selection: $layoutManager.frameStyle)
                    
                    Divider()
                    
                    SettingsPickerView(title: L10n.Layout.Appearance.progressBarStyle, width: 120, selection: $layoutManager.progressBarStyle)
                }
            }
            
            SettingsCardView {
                SettingsToggleView(title: L10n.Layout.Appearance.matchThemeColor, description: L10n.Layout.Appearance.MatchThemeColor.info, option: $layoutManager.matchThemeColor)
            }
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .onChange(of: layoutManager.frameStyle) { _ in
            if OverlayManager.shared.syncOverlayFrame {
                OverlayManager.shared.overlayFrameStyle = layoutManager.frameStyle
            }
        }
        .padding()
    }
}

#Preview {
    LayoutSettingsView()
}
