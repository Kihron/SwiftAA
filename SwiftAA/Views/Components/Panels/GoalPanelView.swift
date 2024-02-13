//
//  GoalView.swift
//  SwiftAA
//
//  Created by Kihron on 7/20/22.
//

import SwiftUI

struct GoalPanelView: View {
    @ObservedObject private var dataManager = DataManager.shared
    
    @Binding var advancement: Advancement
    @State var completedTotal: Int = 0
    @State var rowCount: Int
    @State var goal: String
    @State var isMinimal: Bool = false
    @State var isAdjacent: Bool = false
    
    var horizontalSpacing: CGFloat {
        return isMinimal ? 16 : 2
    }
    
    var columnSpacing: CGFloat {
        return isMinimal ? 10 : 5
    }

    var body: some View {
        VStack(alignment: .leading) {
            if isAdjacent {
                adjacent
            } else {
                standard
            }

            ProgressBarView(value: .constant($advancement.criteria.filter({$0.wrappedValue.completed}).count), total: .constant(advancement.criteria.count), title: goal)
        }
        .padding(4)
        .applyThemeModifiers()
    }
    
    var standard: some View {
        ZStack(alignment: .leading) {
            if !isMinimal {
                IndicatorView(indicator: $advancement.asIndicator)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            
            LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 16), spacing: horizontalSpacing, alignment: .leading), count: rowCount), spacing: columnSpacing) {
                
                if !isMinimal {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                ForEach($advancement.criteria, id: \.self.id) { item in
                    CriterionView(criterion: item)
                }
                .frame(alignment: .leading)
            }
            .frame(maxHeight: .infinity)
            .padding(.leading, 5)
            .padding(.top, isMinimal ? 10 : 3)
            .padding(.bottom, isMinimal ? 10 : 0)
        }
    }
    
    var adjacent: some View {
        HStack(alignment: .top) {
            if !isMinimal {
                IndicatorView(indicator: $advancement.asIndicator)
            }
            
            LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 16), spacing: horizontalSpacing, alignment: .leading), count: rowCount), spacing: columnSpacing) {
                
                ForEach($advancement.criteria, id: \.self.id) { item in
                    CriterionView(criterion: item)
                }
                .frame(alignment: .leading)
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .padding(.leading, 5)
            .padding(.top, isMinimal ? 10 : 3)
            .padding(.bottom, isMinimal ? 10 : 0)
        }
    }
}

#Preview {
    GoalPanelView(advancement: DataManager.shared.decode(file: "adventure")[18].asAdvancement, rowCount: 16, goal: L10n.Goal.Biomes.visited)
        .frame(width: 350)
}
