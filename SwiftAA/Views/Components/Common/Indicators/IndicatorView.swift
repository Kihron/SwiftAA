//
//  Advancement.swift
//  SwiftAA
//
//  Created by Kihron on 7/19/22.
//

import SwiftUI
import Quartz

struct IndicatorView: View {
    @ObservedObject private var overlayManager = OverlayManager.shared
    @ObservedObject private var layoutManager = LayoutManager.shared
    @ObservedObject private var themeManager = ThemeManager.shared
    
    @Binding var indicator: Indicator
    @State var isOverlay: Bool = false
    @State var isStat: Bool = false
    @State var isMinimal: Bool = false
    @State private var showTooltip: Bool = false
    
    var name: String {
        if isStat {
            return indicator.key
        } else if let shortName = (indicator as? Advancement)?.shortName, isMinimal {
            return shortName.localized
        } else {
            return indicator.key.localized(value: indicator.name)
        }
    }
    
    private var frameStyle: FrameStyle {
        if isOverlay && !overlayManager.syncOverlayFrame {
            return overlayManager.overlayFrameStyle
        }
        
        return layoutManager.frameStyle
    }
    
    private var showGlow: Bool {
        let infoModeNotEmptyTip = layoutManager.infoMode && !indicator.tooltip.isEmpty;
        return !isOverlay && ((indicator.completed || infoModeNotEmptyTip) && !(layoutManager.infoMode && indicator.tooltip.isEmpty))
    }
    
    var body: some View {
        VStack(spacing: 3) {
            ZStack {
                Group {
                    switch frameStyle {
                        case .minecraft:
                            MinecraftFrame(indicator: $indicator)
                        case .geode:
                            GeodeFrame(indicator: $indicator)
                        case .modern:
                            ModernFrame(indicator: $indicator)
                    }
                }
                .frame(width: 52, height: 52)
                .padding([.top, .leading, .trailing], 6)
                .overlay {
                    if (showGlow) {
                        Image("frame_glow")
                            .interpolation(.none)
                            .resizable()
                            .brightness(0.3)
                            .saturation(1.7)
                            .opacity(0.6)
                            .frame(width: 128, height: 128)
                            .padding([.top, .leading, .trailing], 6)
                    }
                }
                
                IndicatorIconView(indicator: $indicator, showTooltip: $showTooltip, isOverlay: isOverlay)
                    .animation(.easeIn, value: indicator.icon)
            }
            
            Text(name)
                .minecraftFont()
                .tracking(0.1)
                .foregroundColor(isOverlay ? .white : themeManager.text)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(height: isMinimal ? 12 : 24, alignment: .top)
                .padding(.top, -2)
        }
        .animation(.easeIn, value: frameStyle)
        .opacity(layoutManager.infoMode && indicator.tooltip.isEmpty && !isOverlay ? 0.5 : 1)
        .animation(.easeIn, value: layoutManager.infoMode)
        .frame(width: 74)
        .popover(isPresented: $showTooltip, content: {
            IndicatorInfoView(tooltip: indicator.tooltip)
        })
    }
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView(indicator: .constant(Advancement(id: "bullseye", key: "nether-fast-travel", name: "Sticky Situation", icon: "very_very_frightening", frameStyle: "normal", criteria: [], completed: true)), isOverlay: false, isMinimal: false)
    }
}
