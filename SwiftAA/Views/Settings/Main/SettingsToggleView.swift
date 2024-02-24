//
//  SettingsToggleView.swift
//  SwiftAA
//
//  Created by Kihron on 2/23/24.
//

import SwiftUI

struct SettingsToggleView: View {
    let title: String
    var description: String?
    
    @Binding var option: Bool
    @State private var textHeight: CGFloat = 0
    
    var body: some View {
        HStack(alignment: description != nil && textHeight > 20 ? .top : .center) {
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                
                if let description = description {
                    Text(.init(description))
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.trailing, 2)
                        .background(GeometryReader { geometryProxy in
                            Color.clear.onAppear {
                                self.textHeight = geometryProxy.size.height
                            }
                        })
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Toggle("", isOn: $option)
                .labelsHidden()
                .toggleStyle(.switch)
                .padding(.leading)
        }
    }
}

#Preview {
    SettingsToggleView(title: L10n.Layout.Appearance.matchThemeColor, description: L10n.Layout.Appearance.MatchThemeColor.info, option: .constant(false))
        .padding()
}
