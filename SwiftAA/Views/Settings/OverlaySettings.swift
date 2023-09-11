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
        VStack(spacing: 12) {
            SettingsCardView {
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    OverlaySettings()
        .padding()
}
