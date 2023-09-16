//
//  GoalView.swift
//  SwiftAA
//
//  Created by Kihron on 7/20/22.
//

import SwiftUI

struct GoalPanelView: View {
    @Binding var advancement: Advancement
    @State var completedTotal: Int = 0
    @State var rowCount: Int
    @State var goal: String

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                IndicatorView(indicator: $advancement.asIndicator)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 16), spacing: 2, alignment: .leading), count: rowCount), spacing: 5) {
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    ForEach($advancement.criteria, id: \.self.id) { item in
                        CriterionView(criterion: item)
                    }
                    .frame(alignment: .leading)
                }
                .frame(maxHeight: .infinity)
                .padding(.leading, 5)
                .padding(.top, 3)
            }

            ProgressBarView(value: .constant($advancement.criteria.filter({ criterion in
                    criterion.completed.wrappedValue
            }).count), total: .constant(advancement.criteria.count), title: goal)
        }
        .padding(4)
        .applyThemeModifiers()
    }
}

#Preview {
    GoalPanelView(advancement: DataManager.shared.decode(file: "adventure")[18].asAdvancement, rowCount: 16, goal: L10n.Goal.Biomes.visited)
        .frame(width: 350)
}
