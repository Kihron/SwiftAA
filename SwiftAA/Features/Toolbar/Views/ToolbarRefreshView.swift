//
//  ToolbarRefreshView.swift
//  SwiftAA
//
//  Created by Kihron on 7/22/22.
//

import SwiftUI

struct ToolbarRefreshView: View {
    @Access(\.trackerEngine.trackerContext.lastRefresh) private var lastRefresh
    @Access(\.progressManager) private var progressManager

    @ObservedObject private var layoutManager = LayoutManager.shared
    
    @State private var isVisible = false
    
    var id: String {
        return layoutManager.refreshStyle.label + layoutManager.refreshSpeed.description
    }
    
    var body: some View {
        VStack {
            AnimatedIconView(icon: layoutManager.refreshStyle.icon, speedMultiplier: layoutManager.refreshSpeed)
                .id(id)
                .frame(width: 32, height: 32)
                .opacity(isVisible ? 5 : 0)
                .animation(.easeInOut(duration: 1), value: isVisible)
                .onChange(of: lastRefresh) { _, _ in
                    refreshVisibility()
                }
                .onChange(of: layoutManager.refreshStyle) { _, _ in
                    refreshVisibility(settingChanged: true)
                }
                .onChange(of: layoutManager.refreshSpeed) { _, _ in
                    refreshVisibility(settingChanged: true)
                }
        }
    }
    
    private func refreshVisibility(settingChanged: Bool = false) {
        isVisible = false
        if !progressManager.advancementsState.isEmpty || settingChanged {
            isVisible = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isVisible = false
            }
        }
    }
}

struct ToolbarRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarRefreshView()
            .frame(width: 50, height: 50)
    }
}
