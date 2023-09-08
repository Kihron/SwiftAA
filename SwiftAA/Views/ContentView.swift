//
//  ContentView.swift
//  SwiftAA
//
//  Created by Kihron on 7/20/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject private var themeManager = UIThemeManager.shared
    
    @FetchRequest(entity: UserThemes.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserThemes.name, ascending: true)])
    private var fetch: FetchedResults<UserThemes>
    
    var body: some View {
        ScrollView(.vertical) {
            ScrollView(.horizontal) {
                ZStack {
                    VStack(alignment: .leading, spacing: 0) {
                        switch TrackerManager.shared.gameVersion {
                            case .v1_16 : L1_16()
                            case .v1_19 : L1_19()
                        }
                    }
                    
                    RoundedCornersShape(radius: 10, corners: [.bottomLeft, .bottomRight])
                        .stroke(themeManager.border, lineWidth: 1.5)
                        .padding(.top, 1)
                        .padding(1)
                }
            }
        }
        .onAppear {
            themeManager.getUserThemesFromFetch(fetch: fetch)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 1431, height: 754)
    }
}
