//
//  GoalView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/20/22.
//

import SwiftUI

struct GoalView: View {
    @Binding var advancement: Advancement
    @State var completedTotal: Int = 0
    @State var rowCount: Int
    @State var goal: String
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 16), spacing: 2, alignment: .leading), count: rowCount), spacing: 5) {
                Spacer()
                Spacer()
                
                IndicatorView(indicator: $advancement.asIndicator)

                Spacer()
                Spacer()
                
                ForEach($advancement.criteria, id: \.self.id) { item in
                    CriterionView(criterion: item)
                }
                .frame(alignment: .leading)
            }
            .frame(maxHeight: .infinity)
            .padding(.leading, 5)

            ProgressBarView(value: .constant($advancement.criteria.filter({ criterion in
                return criterion.completed.wrappedValue
            }).count), total: advancement.criteria.count, title: goal)
        }
        .padding(4)
        .background(Color("ender_pearl_background"))
        .border(Color("ender_pearl_border"), width: 2)
    }
}

struct GoalView_Previews: PreviewProvider {
    @ObservedObject static var dataHandler = DataHandler()
    
    static var previews: some View {
        GoalView(advancement: dataHandler.decode(file: "adventure")[18].asAdvancement, rowCount: 16, goal: "Biomes Visited")
            .frame(width: 500, height: 400)
    }
}
