//
//  ToolbarRefreshView.swift
//  SwiftAA
//
//  Created by Kihron on 7/22/22.
//

import SwiftUI

struct ToolbarRefreshView: View {
    @ObservedObject private var progressManager = ProgressManager.shared
    @ObservedObject private var dataManager = DataManager.shared
    @State private var isVisible = false
    
    var body: some View {
        Image("xp_orb")
            .interpolation(.none)
            .resizable()
            .frame(width: 32, height: 32)
            .opacity(isVisible ? 5 : 0)
            .animation(.easeInOut(duration: 1), value: isVisible)
            .onChange(of: dataManager.lastModified) { _ in
                if !progressManager.advancementsState.isEmpty {
                    isVisible = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isVisible = false
                    }
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
