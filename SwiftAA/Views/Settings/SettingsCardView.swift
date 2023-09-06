//
//  SettingsCardView.swift
//  SwiftAA
//
//  Created by Kihron on 1/28/23.

import SwiftUI

struct SettingsCardView<Content: View>: View {
    var padding: CGFloat?
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            content()
                .padding(10)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray), lineWidth: 0.5)
                )
        }
        .padding(padding ?? 0)
    }
}

struct SettingsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCardView() {
            Text("Hello")
                .font(.custom("Minecraft-Regular", size: 10))
        }
        .padding()
        .frame(width: 200, height: 200)
    }
}
