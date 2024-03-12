//
//  UpdateReleaseEntryView.swift
//  SwiftAA
//
//  Created by Kihron on 3/8/24.
//

import SwiftUI

struct UpdateReleaseEntryView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @State private var textSize: CGSize = .zero
    
    var title: String?
    @State var releaseEntry: ReleaseEntry
    
    private var message: String {
        return releaseEntry.message.replacingOccurrences(of: "-", with: "•").replacingOccurrences(of: "### ", with: "")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title ?? String(releaseEntry.tagName.dropFirst()))
                .foregroundStyle(themeManager.border.hex == themeManager.text.hex ? themeManager.background : themeManager.text)
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(themeManager.border)
                }
                .padding(5)
            
            ZStack(alignment: .topLeading) {
                ZStack(alignment: .top) {
                    Circle()
                        .fill(.white)
                        .frame(width: 12)
                    
                    if textSize.height > 20 {
                        Rectangle()
                            .frame(width: 2)
                    }
                }
                .offset(x: 8, y: 2)
                
                Text(.init(message))
                    .padding(.horizontal, 25)
                    .modifier(SizeReader(size: $textSize))
            }
        }
    }
}

#Preview {
    UpdateReleaseEntryView(releaseEntry: .init(id: 2412, tagName: "v1.1.0", publishedAt: Date.now, message: "This update is super cool!"))
}
