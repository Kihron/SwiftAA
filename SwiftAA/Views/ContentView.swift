//
//  ContentView.swift
//  SwiftAA
//
//  Created by Kihron on 7/20/22.
//

import SwiftUI
import Cocoa

struct ContentView: View {
    @EnvironmentObject var settings: AppSettings
    @ObservedObject var dataHandler: DataHandler
    @Binding var changed: Bool
    
    var body: some View {
        ScrollView(.vertical) {
            ScrollView(.horizontal) {
                VStack(alignment: .leading, spacing: 0) {
                    switch settings.gameVersion {
                    case "1.16" :                     L1_16(dataHandler: dataHandler)
                    case "1.19" :                     L1_19(dataHandler: dataHandler)
                    default:
                        L1_16(dataHandler: dataHandler)
                    }
                }
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
                if (changed) {
                    withAnimation {
                        changed = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @ObservedObject static var dataHandler = DataHandler()
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        ContentView(dataHandler: dataHandler, changed: .constant(false))
            .frame(width: 1431, height: 754)
            .environmentObject(settings)
    }
}
