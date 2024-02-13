//
//  ProgressBarView.swift
//  SwiftAA
//
//  Created by Kihron on 7/20/22.
//

import SwiftUI

struct ProgressBarView: View {
    @ObservedObject private var layoutManager = LayoutManager.shared
    @ObservedObject private var themeManager = ThemeManager.shared
    
    @Binding var value: Int
    @Binding var total: Int
    @State var title: String
    @Binding var message: String
    @State var isToolbar: Bool
    
    init(value: Binding<Int>, total: Binding<Int>, title: String, message: Binding<String> = .constant(""), isToolbar: Bool = false) {
        _value = value
        _total = total
        self.title = title
        _message = message
        self.isToolbar = isToolbar
    }
    
    private var header: String {
        return "\(value) / \(total) \(title) (\(total == 0 ? 0 : (value * 100 / total))%)"
    }
    
    private var alignment: HorizontalAlignment {
        return isToolbar ? .leading : .center
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: 5) {
            HStack {
                Text(header)
                if !message.isEmpty {
                    Spacer()
                    Text(message)
                }
            }
            .padding(.horizontal, 5)
            .minecraftFont()
            .foregroundColor(isToolbar ? Color.primary : themeManager.text)
            
            GeometryReader { item in
                switch layoutManager.progressBarStyle {
                    case .enderDragon:
                        EnderDragonProgressBar(item: item, value: $value, total: $total)
                    case .experience:
                        ExperienceProgressBarView(item: item, value: $value, total: $total)
                }
            }
            .animation(.easeIn, value: layoutManager.progressBarStyle)
            .frame(height: 10)
        }
        .padding(5)
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(value: .constant(33), total: .constant(34), title: "Biomes Visited")
            .frame(width: 354, height: 100)
    }
}
