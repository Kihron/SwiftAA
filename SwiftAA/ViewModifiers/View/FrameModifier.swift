//
//  FrameModifier.swift
//  SwiftAA
//
//  Created by Kihron on 8/22/22.
//

import SwiftUI

struct FrameModifier: ViewModifier {
    @Binding var gameVersion: String
    
    func body(content: Content) -> some View {
        switch gameVersion {
        case "1.16" :
            content
                .frame(minWidth: 350, idealWidth: 1431, maxWidth: 1431, minHeight: 260, idealHeight: 754, maxHeight: 754, alignment: .center)
        case "1.19" :
            content
                .frame(minWidth: 350, idealWidth: 1702, maxWidth: 1702, minHeight: 260, idealHeight: 754, maxHeight: 754, alignment: .center)
        default :
            content
                .frame(minWidth: 350, idealWidth: 1431, maxWidth: 1431, minHeight: 260, idealHeight: 754, maxHeight: 754, alignment: .center)
        }
    }
}

extension View {
    func applyVersionFrame(gameVersion: Binding<String>) -> some View {
        modifier(FrameModifier(gameVersion: gameVersion))
    }
}
