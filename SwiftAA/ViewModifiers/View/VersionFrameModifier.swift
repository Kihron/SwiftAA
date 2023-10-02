//
//  VersionFrameModifier.swift
//  SwiftAA
//
//  Created by Kihron on 8/22/22.
//

import SwiftUI

struct VersionFrameModifier: ViewModifier {
    @ObservedObject private var trackerManager = TrackerManager.shared
    
    func body(content: Content) -> some View {
        switch (trackerManager.gameVersion, trackerManager.layoutStyle)  {
            case (.v1_16, .standard):
                content
                    .frame(minWidth: 350, idealWidth: 1431, maxWidth: 1431, minHeight: 260, idealHeight: 764, maxHeight: 764, alignment: .center)
            case (.v1_16, .vertical):
                content
                    .frame(minWidth: 350, idealWidth: 1431, maxWidth: 1431, minHeight: 260, idealHeight: 764, maxHeight: 764, alignment: .center)
            case (.v1_16, .minimalist):
                content
                    .frame(minWidth: 350, idealWidth: 1192, maxWidth: 1192, minHeight: 260, idealHeight: 714, maxHeight: 714, alignment: .center)
            case (.v1_19, _):
                content
                    .frame(minWidth: 350, idealWidth: 1702, maxWidth: 1702, minHeight: 260, idealHeight: 764, maxHeight: 764, alignment: .center)
        }
    }
}

extension View {
    func applyVersionFrame() -> some View {
        modifier(VersionFrameModifier())
    }
}
