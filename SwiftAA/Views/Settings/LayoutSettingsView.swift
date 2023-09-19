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
        VStack {
            SettingsCardView {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Modular Panel")
                        
                        Text("Switch between multiple panels to display different types of information located on the far right.")
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
            
            SettingsLabel(title: "Styling")
                .padding(.top, 5)
            
            SettingsCardView {
                VStack {
                    HStack {
                        Text("Frame Style")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Picker("", selection: $layoutManager.frameStyle) {
                            ForEach(FrameStyle.allCases, id: \.self) { item in
                                Text(item.label.localized)
                            }
                        }
                        .frame(maxWidth: 90)
                        .labelsHidden()
                    }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    LayoutSettingsView()
}
