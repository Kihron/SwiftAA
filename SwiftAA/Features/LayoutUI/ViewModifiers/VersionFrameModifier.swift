//
//  VersionFrameModifier.swift
//  SwiftAA
//
//  Created by Kihron on 8/22/22.
//

import SwiftUI

struct VersionFrameModifier: ViewModifier {
    @AppSettings(\.tracker) private var settings
    @State private var hasChanged: Bool = false
    
    func body(content: Content) -> some View {
        Group {
            switch (settings.gameVersion, settings.layoutStyle)  {
                case (.v1_16, .standard), (.v1_16_5, .standard):
                    content
                        .frame(minWidth: 350, idealWidth: 1431, maxWidth: 1431, minHeight: 260, idealHeight: 764, maxHeight: 764, alignment: .center)
                case (.v1_16, .vertical), (.v1_16_5, .vertical):
                    content
                        .frame(minWidth: 350, idealWidth: 680, maxWidth: 680, minHeight: 260, idealHeight: 1126, maxHeight: 1126, alignment: .center)
                case (.v1_16, .minimalist), (.v1_16_5, .minimalist):
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
                case (.v1_21, .standard), (.v1_21_4, .standard):
                    content
                        .frame(minWidth: 350, idealWidth: 1672, maxWidth: 1672, minHeight: 260, idealHeight: 852, maxHeight: 852, alignment: .center)
                case (.v1_21, .vertical), (.v1_21_4, .vertical):
                    content
                        .frame(minWidth: 350, idealWidth: 710, maxWidth: 710, minHeight: 260, idealHeight: 1391, maxHeight: 1391, alignment: .center)
                case (.v1_21, .minimalist), (.v1_21_4, .minimalist):
                    content
                        .frame(minWidth: 350, idealWidth: 1488, maxWidth: 1488, minHeight: 260, idealHeight: 748, maxHeight: 748, alignment: .center)
                
            }
        }
        .fixedSize(horizontal: hasChanged, vertical: hasChanged)
        .onChange(of: settings.gameVersion) { _, _ in
            handleDimensionChange()
        }
        .onChange(of: settings.layoutStyle) { _, _ in
            handleDimensionChange()
        }
    }
    
    private func handleDimensionChange() {
        if settings.automaticExpansion {
            hasChanged = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.hasChanged = false
            }
        }
    }
}

extension View {
    func applyVersionFrame() -> some View {
        modifier(VersionFrameModifier())
    }
}
