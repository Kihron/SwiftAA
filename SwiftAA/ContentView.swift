//
//  ContentView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI

struct ContentView: View {
    var advancements: [Indicator] = [Advancement(id: "bullseye", name: "Bullseye", icon: "bullseye", frameStyle: .challenge, completed: false), Advancement(id: "postmortal", name: "Postmortal", icon: "totem_of_undying", frameStyle: .goal, completed: false)]
    let rows = [GridItem(.adaptive(minimum: 64)), GridItem(.adaptive(minimum: 64))]
    
    var body: some View {
        LazyHGrid(rows: rows) {
            ForEach(advancements, id: \.self.id, content: AdvancementView.init)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 500, height: 500)
    }
}
