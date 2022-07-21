//
//  ContentView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI

struct AdvGroupView: View {
    @State var advancements: [Advancement]
    @State var columnCount: Int
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 64), spacing: 0), count: columnCount), spacing: 0) {
            ForEach(advancements, id: \.self.id, content: AdvancementView.init)
        }
        .padding(4)
        .background(Color("ender_pearl_background"))
        .border(Color("ender_pearl_border"), width: 2)
    }
}

struct AdvGroupView_Previews: PreviewProvider {
    @ObservedObject static var dataHandler = DataHandler()
    
    static var previews: some View {
        AdvGroupView(advancements: dataHandler.decode(file: "adventure"), columnCount: 2)
            .frame(width: 300, height: 500)
    }
}
