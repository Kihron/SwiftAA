//
//  ToolbarRefreshView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/22/22.
//

import SwiftUI

struct ToolbarRefreshView: View {
    @Binding var visible: Bool
    
    var body: some View {
        Image("xp_orb")
            .interpolation(.none)
            .resizable()
            .frame(width: 32, height: 32)
            .opacity(visible ? 5 : 0)
            .animation(.linear(duration: 1), value: visible)
    }
}

struct ToolbarRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarRefreshView(visible: .constant(true))
            .frame(width: 50, height: 50)
    }
}
