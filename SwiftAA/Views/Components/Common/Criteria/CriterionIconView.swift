//
//  CriterionIconView.swift
//  SwiftAA
//
//  Created by Kihron on 2/25/24.
//

import SwiftUI

struct CriterionIconView: View {
    @Binding var criterion: Criterion
    @State private var isVisible: Bool = false
    var isOverlay: Bool = false
    
    var opacity: Double {
        return criterion.completed || isOverlay ? 1 : 0.3
    }
    
    var body: some View {
        if Constants.animatedIcons.contains(criterion.icon) {
            VStack {
                if isVisible {
                    AnimatedIconView(icon: criterion.icon)
                        .frame(width: 16, height: 16)
                        .opacity(opacity)
                }
            }
            .onAppear {
                isVisible = true
            }
            .onDisappear {
                isVisible = false
            }
        } else {
            Image(criterion.icon)
                .frame(width: 16, height: 16)
                .opacity(opacity)
            
            if let dual = criterion as? Criterion.DualCriterion, dual.recipe.contains("trim") {
                Image("smithing_table")
                    .frame(width: 16, height: 16)
                    .opacity(dual.secondaryCompleted ? 1 : 0.3)
            }
        }
    }
}
