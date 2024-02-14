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
    @ObservedObject private var overlayManager = OverlayManager.shared
    
    @Binding var value: Int
    @Binding var total: Int
    @State var title: String
    @Binding var message: String
    @State var isToolbar: Bool
    @State var isOverlay: Bool
    
    init(value: Binding<Int>, total: Binding<Int>, title: String, message: Binding<String> = .constant(""), isToolbar: Bool = false, isOverlay: Bool = false) {
        _value = value
        _total = total
        self.title = title
        _message = message
        self.isToolbar = isToolbar
        self.isOverlay = isOverlay
    }
    
    private var header: String {
        return "\(value) / \(total) \(title) (\(total == 0 ? 0 : (value * 100 / total))%)"
    }
    
    private var alignment: HorizontalAlignment {
        return isToolbar ? .leading : .center
    }
    
    private var adjustForOverlay: Bool {
        return !isOverlay || (isOverlay && overlayManager.showOptimalProgressBar)
    }
    
    private var showMessage: Bool {
        return !isOverlay || (isOverlay && overlayManager.showInGameTime)
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: 5) {
            HStack {
                Text(header)
                
                Spacer()
                
                if !message.isEmpty && showMessage {
                    Text(message)
                }
            }
            .padding(.horizontal, adjustForOverlay ? 5 : 0)
            .minecraftFont()
            .foregroundColor(isToolbar ? Color.primary : themeManager.text)
            
            if adjustForOverlay {
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
        }
        .padding(adjustForOverlay ? 5 : 0)
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(value: .constant(15), total: .constant(110), title: "Biomes Visited")
            .frame(width: 280, height: 100)
    }
}
