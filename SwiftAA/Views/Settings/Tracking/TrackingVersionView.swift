//
//  TrackingVersionView.swift
//  SwiftAA
//
//  Created by Kihron on 2/7/24.
//

import SwiftUI

struct TrackingVersionView: View {
    @ObservedObject private var trackerManager = TrackerManager.shared
    @ObservedObject private var dataManager = DataManager.shared
    
    var body: some View {
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
                    }
                }
            }
        }
    }
}

#Preview {
    TrackingVersionView()
}
