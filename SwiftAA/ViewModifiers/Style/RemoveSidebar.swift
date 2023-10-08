//
//  RemoveSidebar.swift
//  SwiftAA
//
//  Created by Kihron on 10/7/23.
//

import SwiftUI

struct RemoveSidebar: ViewModifier {
    func body(content: Content) -> some View {
        if #available(macOS 14.0, *) {
            content
                .toolbar(removing: .sidebarToggle)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: 32, height: 32)
                    }
                }
        } else {
            content
        }
    }
}

extension View {
    func removeSidebar() -> some View {
        self.modifier(RemoveSidebar())
    }
}
