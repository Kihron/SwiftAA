//
//  CriterionView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI

struct CriterionView: View {
    @State var criterion: Criterion
    
    var body: some View {
        HStack {
            Image(criterion.icon)
                .frame(width: 16, height: 16)
            
            Text(criterion.name)
                .font(.custom("Minecraft-Regular", size: 10))
        }
        .opacity(criterion.completed ? 1 : 0.3)
        .padding()
    }
}

struct CriterionView_Previews: PreviewProvider {
    static var previews: some View {
        CriterionView(criterion: Criterion(id: "plains", name: "Plains", icon: "plains", completed: false))
    }
}
