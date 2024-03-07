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
    @State private var textHeight: CGSize = .zero
    
    var filter: [T]?
    var options: [T] {
        if let filter = filter {
            return filter
        } else {
            return Array(T.allCases)
        }
    }
    
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
            
            Picker("", selection: $selection) {
                ForEach(options, id: \.id) { item in
                    Text(item.label.localized)
                }
            }
            .frame(maxWidth: width)
            .labelsHidden()
        }
        .animation(nil, value: textHeight)
    }
}

#Preview {
    SettingsPickerView(title: "Example Picker", width: 105, selection: .constant(FrameStyle.modern))
        .padding()
}
