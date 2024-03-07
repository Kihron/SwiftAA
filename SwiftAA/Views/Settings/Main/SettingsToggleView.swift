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
    @State private var textHeight: CGSize = .zero
    
    var body: some View {
        HStack(alignment: description != nil && textHeight.height > 20 ? .top : .center) {
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                
                if let description = description {
                    Text(.init(description))
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.trailing, 2)
                        .modifier(SizeReader(size: $textHeight))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Toggle("", isOn: $option)
                .labelsHidden()
                .toggleStyle(.switch)
                .padding(.leading)
        }
        .animation(nil, value: textHeight)
    }
}

#Preview {
    SettingsToggleView(title: L10n.Layout.Appearance.matchThemeColor, description: L10n.Layout.Appearance.MatchThemeColor.info, option: .constant(false))
        .padding()
}
