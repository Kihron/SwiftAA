//
//  CriterionView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI

struct CriterionView: View {
    @Binding var criterion: Criterion
    
    var body: some View {
        HStack {
            if (isAnimated(icon: criterion.icon)) {
                QLImage(criterion.icon)
                    .frame(width: 16, height: 16)
            } else {
                Image(criterion.icon)
                    .frame(width: 16, height: 16)
            }
            
            Text(criterion.name)
                .font(.custom("Minecraft-Regular", size: 10))
        }
        .opacity(criterion.completed ? 1 : 0.3)

    }
    
    func isAnimated(icon: String) -> Bool {
        return ["enchant_item", "enchanted_golden_apple", "summon_wither"].contains(icon)
    }
}

struct CriterionView_Previews: PreviewProvider {
    static var previews: some View {
        CriterionView(criterion: .constant(Criterion(id: "plains", name: "Plains", icon: "plains", completed: false)))
    }
}
