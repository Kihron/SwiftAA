//
//  GoalView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/20/22.
//

import SwiftUI

struct GoalView: View {
    @State var advancement: Advancement
    @State var rowCount: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 16), spacing: 2, alignment: .leading), count: rowCount), spacing: 5) {
                Spacer()
                Spacer()
                
                AdvancementView(indicator: advancement)
                
                Spacer()
                Spacer()
                
                ForEach(advancement.criteria, id: \.self.id, content: CriterionView.init)
                    .frame(alignment: .leading)
            }
            .frame(maxHeight: .infinity)
            .padding(.leading, 5)

            ProgressBarView(value: 0, total: advancement.criteria.count, title: "Biomes Visited")
        }
        .padding(4)
        .background(Color("ender_pearl_background"))
        .border(Color("ender_pearl_border"), width: 2)
    }
}

struct GoalView_Previews: PreviewProvider {
    @ObservedObject static var dataHandler = DataHandler()
    
    static var previews: some View {
        GoalView(advancement: dataHandler.decode(file: "adventure")[18], rowCount: 16)
            .frame(width: 500, height: 400)
    }
}
