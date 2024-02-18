//
//  OptimalOverlayView.swift
//  SwiftAA
//
//  Created by Kihron on 11/27/23.
//

import SwiftUI

struct OptimalOverlayView: View {
    @ObservedObject private var dataManager = DataManager.shared
    @ObservedObject private var overlayManager = OverlayManager.shared
    
    var body: some View {
        VStack(spacing: 6) {
            ProgressBarView(value: .constant(dataManager.completedAdvancements.count), total: .constant(dataManager.allAdvancements.count), title: L10n.Goal.advancements, message: .constant("IGT: \(dataManager.ticksToIGT(ticks: dataManager.playTime))"), isToolbar: true, isOverlay: true)
                .padding(.horizontal)
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(dataManager.completedAdvancements.isEmpty ? "Categories" : "Recently Completed")
                        .minecraftFont(size: 12)
                        .padding(.horizontal)
                    
                    HStack(spacing: 0) {
                        if dataManager.completedAdvancements.isEmpty {
                            createIndicator(name: "Minecraft", icon: "grass")
                            createIndicator(name: "Nether", icon: "nether")
                            createIndicator(name: "End", icon: "end")
                            createIndicator(name: "Adventure", icon: "adventure")
                            createIndicator(name: "Husbandry", icon: "husbandry")
                        } else {
                            ForEach(dataManager.completedAdvancements.suffix(5).reversed()) { adv in
                                IndicatorView(indicator: .constant(adv), isOverlay: true)
                            }
                        }
                    }
                    .frame(width: 370, alignment: .leading)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    if !dataManager.completedCriteria.isEmpty {
                        Text(dataManager.completedAdvancements.isEmpty ? "" : "Criteria")
                            .minecraftFont(size: 12)
                            .padding([.bottom, .leading], 8)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 24), spacing: 0), count: 5), spacing: 10) {
                            ForEach(dataManager.completedCriteria.suffix(10).reversed()) { criterion in
                                ZStack {
                                    Group {
                                        Image(criterion.icon)
                                            .resizable()
                                            .interpolation(.none)
                                            .frame(width: 24, height: 24)
                                    }
                                    
                                    if overlayManager.clarifyAmbigiousCriteria && Constants.ambigiousCriteria.contains(criterion.icon) {
                                        if let adv = dataManager.getAdvancementForCriteria(criterion: criterion) {
                                            Image(adv.icon)
                                                .resizable()
                                                .interpolation(.none)
                                                .frame(width: 24, height: 24)
                                                .offset(x: -8, y: -5)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .topLeading)
                        .frame(width: 205, height: 72)
                    }
                }
                .padding(.trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            StatusIndicatorRowView()
                .frame(height: 70)
                .padding(.bottom)
        }
        .animation(.smooth, value: overlayManager.showOptimalProgressBar)
    }
    
    private func createIndicator(name: String, icon: String) -> IndicatorView {
        return IndicatorView(indicator: .constant(Advancement(id: name, key: "", name: name, icon: icon, frameStyle: "normal", criteria: [], completed: false)), isOverlay: true)
    }
}

#Preview {
    OptimalOverlayView()
}
