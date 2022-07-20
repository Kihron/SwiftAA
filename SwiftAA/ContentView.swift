//
//  ContentView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var dataHandler = DataHandler()
    let columns = [GridItem(.adaptive(minimum: 64), spacing: 0), GridItem(.adaptive(minimum: 64), spacing: 0)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(dataHandler.decode(file: "adventure"), id: \.self.id, content: AdvancementView.init)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 500, height: 500)
    }
}
