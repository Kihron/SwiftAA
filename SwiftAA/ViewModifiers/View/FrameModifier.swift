//
//  FrameModifier.swift
//  SwiftAA
//
//  Created by Kihron on 8/22/22.
//

import SwiftUI

struct FrameModifier: ViewModifier {
    @ObservedObject private var versionManager = TrackerManager.shared
    
    func body(content: Content) -> some View {
        switch versionManager.gameVersion {
            case .v1_16 :
                content
                    .frame(minWidth: 350, idealWidth: 1431, maxWidth: 1431, minHeight: 260, idealHeight: 754, maxHeight: 754, alignment: .center)
            case .v1_19 :
                content
                    .frame(minWidth: 350, idealWidth: 1702, maxWidth: 1702, minHeight: 260, idealHeight: 754, maxHeight: 754, alignment: .center)
        }
    }
}

extension View {
    func applyVersionFrame() -> some View {
        modifier(FrameModifier())
    }
}
