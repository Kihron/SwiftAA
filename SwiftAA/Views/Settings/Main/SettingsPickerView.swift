//
//  SettingsPickerView.swift
//  SwiftAA
//
//  Created by Kihron on 2/23/24.
//

import SwiftUI

struct SettingsPickerView<T: SettingsOption>: View {
    let title: String
    var description: String?
    let width: CGFloat
    
    @Binding var selection: T
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
            
            Picker("", selection: $selection) {
                ForEach(Array(T.allCases), id: \.id) { item in
                    Text(item.label.localized)
                }
            }
            .frame(maxWidth: width)
            .labelsHidden()
        }
    }
}

#Preview {
    SettingsPickerView(title: "Example Picker", width: 105, selection: .constant(FrameStyle.modern))
        .padding()
}
