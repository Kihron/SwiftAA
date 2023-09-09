//
//  NewOverlaySettings.swift
//  SwiftAA
//
//  Created by Kihron on 9/8/23.
//

import SwiftUI

struct NewOverlaySettings: View {
    @ObservedObject var overlayManager = OverlayManager.shared
    
    var body: some View {
        VStack {
            SettingsCardView {
                VStack {
                    HStack {
                        Text("Show Statistics")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Toggle("", isOn: $overlayManager.showStatistics)
                            .labelsHidden()
                            .toggleStyle(.switch)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Statistics Alignment")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Picker("", selection: $overlayManager.statisticsAlignment) {
                            ForEach(HAlignment.allCases, id: \.self) { item in
                                Text(item.label)
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
    NewOverlaySettings()
        .padding()
}
