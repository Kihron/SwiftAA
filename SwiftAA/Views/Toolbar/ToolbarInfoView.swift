//
//  ToolbarInfoView.swift
//  SwiftAA
//
//  Created by Kihron on 10/1/23.
//

import SwiftUI

struct ToolbarInfoView: View {
    @ObservedObject private var layoutManager = LayoutManager.shared
    
    var body: some View {
        Button(action: { layoutManager.infoMode.toggle() }) {
            Image(systemName: "info.circle.fill")
                .font(.system(size: 16))
                .foregroundStyle(layoutManager.infoMode ? .blue : .white)
        }
        .buttonStyle(.plain)
        .frame(width: 32, height: 32)
        .animation(.linear, value: layoutManager.infoMode)
    }
}

#Preview {
    ToolbarInfoView()
}
