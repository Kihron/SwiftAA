//
//  OverlayView.swift
//  SwiftAA
//
//  Created by Kihron on 8/3/22.
//

import SwiftUI

struct MultiPageOverlayView: View {
    @ObservedObject private var viewModel = MultiPageOverlayViewModel()
    @ObservedObject private var overlayManager = OverlayManager.shared
    
    @State private var section = 0
    @State private var totalSections = 0
    @State private var criteriaSection = 0
    @State private var criteriaTotalSections = 0
    
    @State private var progress: CGFloat = 0.7
    private let animationTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var alignment: Alignment {
        switch overlayManager.statisticsAlignment {
            case .leading:
                    .leading
            case .center:
                    .center
            case .trailing:
                    .trailing
        }
    }
    
    var body: some View {
        GeometryReader { screen in
            VStack {
                ZStack(alignment: .center) {
                    VStack {
                        HStack {
                            if (overlayManager.showLegacyPageIndicator && max(totalSections, criteriaTotalSections) != 1) {
                                RoundedRectangle(cornerRadius: 5)
                                    .background(.gray)
                                    .opacity(0.5)
                                    .frame(width: max(0, screen.size.width * progress), height: 2)
                            }
                        }
                        .frame(height: 10)
                    }
                    
                    HStack {
                        Text("\(viewModel.completedAdvancements)/\(viewModel.totalAdvancements)")
                            .font(.custom("Minecraft-Regular", size: 12))
                            .padding(.trailing)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading)
                }
                .frame(height: 10)
                .padding(.bottom, 5)
                
                LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 16), spacing: 0, alignment: .leading), count: Int(floor((screen.size.width - 40) / 26))), spacing: 20) {
                    ForEach(viewModel.getCriteriaSection(criteriaSection, screen: screen), id: \.self) { criterion in
                        if (isAnimated(icon: criterion.icon)) {
                            QLImage(criterion.icon)
                                .frame(width: 16, height: 16)
                        } else {
                            Image(criterion.icon)
                                .frame(width: 16, height: 16)
                                .drawingGroup()
                        }
                    }
                }
                .frame(width: screen.size.width - 40, height: 54, alignment: .top)
                .padding(.horizontal)
                .padding(.leading, 10)
                
                LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 74), spacing: 0), count: Int(floor(screen.size.width / 74))), spacing: 0) {
                    ForEach(viewModel.getSection(section, screen: screen), id: \.self) { adv in
                        if isAnimated(icon: adv.icon) {
                            IndicatorView(indicator: .constant(adv), isOverlay: true)
                        } else {
                            IndicatorView(indicator: .constant(adv), isOverlay: true)
                                .drawingGroup()
                        }
                    }
                }
                .frame(width: screen.size.width)
                .padding(.trailing, 4)
                
                
                HStack {
                    if overlayManager.showStatistics {
                        ForEach(viewModel.dataManager.stats, id: \.self.id) { adv in
                            if isAnimated(icon: adv.icon) {
                                IndicatorView(indicator: .constant(adv), isOverlay: true, isStat: true)
                            } else {
                                IndicatorView(indicator: .constant(adv), isOverlay: true, isStat: true)
                                    .drawingGroup()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: alignment)
                .animation(.spring, value: overlayManager.statisticsAlignment)
            }
            .onReceive(animationTimer) { timer in
                withAnimation {
                    self.progress -= (0.01 * (1000 / screen.size.width))
                }
                if progress <= 0.0 {
                    totalSections = viewModel.totalSections(screen: screen)
                    criteriaTotalSections = viewModel.totalCriteriaSections(screen: screen)
                    section = (section + 1) % max(1, totalSections)
                    criteriaSection = (criteriaSection + 1) % criteriaTotalSections
                    self.progress = 0.7
                }
            }
        }
    }
    
    func isAnimated(icon: String) -> Bool {
        ["enchant_item", "enchanted_golden_apple", "summon_wither", "skulk_sensor"].contains(icon)
    }
}

struct OverlayView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPageOverlayView()
            .frame(width: 800, height: 345)
    }
}