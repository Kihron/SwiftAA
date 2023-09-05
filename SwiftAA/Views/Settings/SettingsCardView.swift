//
//  SettingsCardView.swift
//  SwiftAA
//
//  Created by Kihron on 1/28/23.
//

import SwiftUI

struct SettingsCardView<Content: View>: View {
    var title: String?
    var padding: CGFloat?
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let title = title {
                Text(title)
                    .padding(.leading, 10)
                    .font(.custom("Minecraft-Regular", size: 10))
            }

            content()
                .padding(10)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray), lineWidth: 1)
                )
        }
        .padding(padding ?? 0)
    }
}

struct SettingsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCardView(title: "Configuration") {
            Text("Hello")
                .font(.custom("Minecraft-Regular", size: 10))
        }
        .padding()
    }
}
