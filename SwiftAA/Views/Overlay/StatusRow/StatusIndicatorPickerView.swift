//
//  StatusIndicatorPickerView.swift
//  SwiftAA
//
//  Created by Kihron on 10/22/23.
//

import SwiftUI

struct StatusIndicatorPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var dataManager = DataManager.shared
    @ObservedObject private var overlayManager = OverlayManager.shared
    
    @State var isSettings: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(L10n.Overlay.Appearance.StatisticsRow.editor)
                .font(.title2)
                .fontWeight(.bold)
            
            SettingsCardView(padding: 0) {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 74), spacing: 0), count: 6)) {
                        ForEach($dataManager.statusIndicators, id: \.self.id) { indicator in
                            Button(action: {
                                withAnimation(.bouncy) {
                                    toggleActiveIndicator(id: indicator.wrappedValue.id)
                                }
                            }) {
                                ZStack(alignment: .topTrailing) {
                                    IndicatorView(indicator: indicator, isOverlay: true, isStat: true)
                                    
                                    if overlayManager.activeIndicators.contains(indicator.wrappedValue.id) {
                                        ZStack {
                                            Circle()
                                                .fill(.green)
                                            
                                            Image(systemName: "checkmark")
                                                .resizable()
                                                .frame(width: 10, height: 10)
                                                .fontWeight(.bold)
                                        }
                                        .frame(width: 16, height: 16)
                                        .offset(x: -6, y: 3)
                                        .zIndex(1)
                                    }
                                }
                            }.buttonStyle(.plain)
                        }
                    }.padding(10)
                }
            }
            
            Button(action: { dismiss() }) {
                Text(L10n.Button.close)
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .frame(width: 550, height: isSettings ? 400 : 225)
    }
    
    private func toggleActiveIndicator(id: String) {
        if let index = overlayManager.activeIndicators.firstIndex(where: { $0 == id }), overlayManager.activeIndicators.count - 1 > 0 {
            overlayManager.activeIndicators.remove(at: index)
        } else {
            overlayManager.activeIndicators.append(id)
        }
    }
}

#Preview {
    StatusIndicatorPickerView()
        .frame(width: 550, height: 225)
}
