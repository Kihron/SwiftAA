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
    @ObservedObject private var themeManager = UIThemeManager.shared
    
    @Binding var indicator: Indicator
    @State var isOverlay: Bool = false
    @State var isStat: Bool = false
    @State var isMinimal: Bool = false
    @State private var showTooltip: Bool = false
    
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
                
                if (isAnimated(icon: indicator.icon)) {
                    QLImage(indicator.icon)
                        .frame(width: 32, height: 32)
                        .padding(.top, 6)
                } else {
                    Image(indicator.icon)
                        .interpolation(.none)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .padding(.top, 6)
                        .onHover(perform: { hovering in
                            if layoutManager.infoMode && !isOverlay {
                                showTooltip = hovering
                            } else {
                                showTooltip = false
                            }
                        })
                }
            }
            
            Text(isStat ? indicator.key : indicator.key.localized(value: indicator.name))
                .font(.custom("Minecraft-Regular", size: 10))
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
    
    func isAnimated(icon: String) -> Bool {
        ["enchant_item", "enchanted_golden_apple", "summon_wither", "skulk_sensor"].contains(icon)
    }
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView(indicator: .constant(Advancement(id: "bullseye", key: "nether-fast-travel", name: "Sticky Situation", icon: "very_very_frightening", frameStyle: "normal", criteria: [], completed: true)), isOverlay: false, isMinimal: true)
            .frame(width: 100, height: 100)
    }
}
