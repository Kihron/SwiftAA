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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Status Indicators")
                .font(.title2)
                .fontWeight(.bold)
            
            SettingsCardView {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 74), spacing: 0), count: 6), spacing: 0) {
                        ForEach($dataManager.stats, id: \.self.id) { indicator in
                            GeometryReader { geo in
                                Button(action: {
                                    withAnimation(.bouncy) {
                                        toggleActiveIndicator(id: indicator.wrappedValue.id)
                                    }
                                }) {
                                    ZStack(alignment: .topTrailing) {
                                        IndicatorView(indicator: indicator, isOverlay: true, isStat: true)
                                        
                                        if !overlayManager.nonActiveIndicators.contains(indicator.wrappedValue.id) {
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
                        }
                    }
                }
            }
            
            Button(action: { dismiss() }) {
                Text("Close")
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .frame(width: 550, height: 225)
    }
    
    private func toggleActiveIndicator(id: String) {
        if let index = overlayManager.nonActiveIndicators.firstIndex(where: { $0 == id }) {
            overlayManager.nonActiveIndicators.remove(at: index)
        } else {
            if overlayManager.nonActiveIndicators.count < Constants.statusIndicators.count - 1 {
                overlayManager.nonActiveIndicators.append(id)
            }
        }
    }
}

#Preview {
    StatusIndicatorPickerView()
        .frame(width: 550, height: 225)
}
