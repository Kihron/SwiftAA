//
//  ContentView.swift
//  SwiftAA
//
//  Created by Kihron on 7/20/22.
//

import SwiftUI
import Cocoa

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical) {
            ScrollView(.horizontal) {
                VStack(alignment: .leading, spacing: 0) {
                    switch TrackerManager.shared.gameVersion {
                        case .v1_16 : L1_16()
                        case .v1_19 : L1_19()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 1431, height: 754)
    }
}
