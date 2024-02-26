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
                    .frame(minWidth: 350, idealWidth: 680, maxWidth: 680, minHeight: 260, idealHeight: 1126, maxHeight: 1126, alignment: .center)
            case (.v1_16, .minimalist):
                content
                    .frame(minWidth: 350, idealWidth: 1192, maxWidth: 1192, minHeight: 260, idealHeight: 674, maxHeight: 674, alignment: .center)
            case (.v1_19, _):
                content
                    .frame(minWidth: 350, idealWidth: 1672, maxWidth: 1672, minHeight: 260, idealHeight: 764, maxHeight: 764, alignment: .center)
            case (.v1_20, .standard):
                content
                    .frame(minWidth: 350, idealWidth: 1746, maxWidth: 1746, minHeight: 260, idealHeight: 769, maxHeight: 769, alignment: .center)
            case (.v1_20, .vertical):
                content
                    .frame(minWidth: 350, idealWidth: 680, maxWidth: 680, minHeight: 260, idealHeight: 1391, maxHeight: 1391, alignment: .center)
            case (.v1_20, .minimalist):
                content
                    .frame(minWidth: 350, idealWidth: 1488, maxWidth: 1488, minHeight: 260, idealHeight: 674, maxHeight: 674, alignment: .center)
        }
    }
}

extension View {
    func applyVersionFrame() -> some View {
        modifier(VersionFrameModifier())
    }
}
