//
//  LayoutSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/18/23.
//

import SwiftUI

struct LayoutSettingsView: View {
    @ObservedObject private var layoutManager = LayoutManager.shared
    
    var body: some View {
        VStack(spacing: 12) {
            SettingsCardView {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(L10n.Layout.modularPanel)
                        
                        Text(L10n.Layout.ModularPanel.info)
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .padding(.trailing, 2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Picker("", selection: $layoutManager.modularPanel) {
                        ForEach(ModularPanel.allCases, id: \.self) { item in
                            Text(item.label.localized)
                        }
                    }
                    .frame(maxWidth: 110)
                    .labelsHidden()
                }
            }
            
            SettingsLabel(title: L10n.Layout.appearance)
                .padding(.top, 5)
            
            SettingsCardView {
                VStack {
                    HStack {
                        Text(L10n.Layout.Appearance.frameStyle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Picker("", selection: $layoutManager.frameStyle) {
                            ForEach(FrameStyle.allCases, id: \.self) { item in
                                Text(item.label.localized)
                            }
                        }
                        .frame(maxWidth: 90)
                        .labelsHidden()
                    }
                    
                    Divider()
                    
                    HStack {
                        Text(L10n.Layout.Appearance.progressBarStyle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Picker("", selection: $layoutManager.progressBarStyle) {
                            ForEach(ProgressBarStyle.allCases, id: \.self) { item in
                                Text(item.label.localized)
                            }
                        }
                        .frame(maxWidth: 120)
                        .labelsHidden()
                    }
                }
            }
            
            SettingsCardView {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(L10n.Layout.Appearance.matchThemeColor)
                        
                        Text(L10n.Layout.Appearance.MatchThemeColor.info)
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .padding(.trailing, 2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Toggle("", isOn: $layoutManager.matchThemeColor)
                        .labelsHidden()
                        .toggleStyle(.switch)
                }
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
