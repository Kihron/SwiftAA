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
    
    var body: some View {
        if Constants.animatedIcons.contains(criterion.icon) {
            VStack {
                if isVisible {
                    AnimatedIconView(icon: criterion.icon)
                        .frame(width: 16, height: 16)
                        .opacity(criterion.completed ? 1 : 0.3)
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
                .opacity(criterion.completed ? 1 : 0.3)
            
            if let dual = criterion as? Criterion.DualCriterion, dual.recipe.contains("trim") {
                Image("smithing_table")
                    .frame(width: 16, height: 16)
                    .opacity(dual.secondaryCompleted ? 1 : 0.3)
            }
        }
    }
}
