//
//  OverlayView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 8/3/22.
//

import SwiftUI

struct OverlayView: View {
    @ObservedObject var dataHandler: DataHandler
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct OverlayView_Previews: PreviewProvider {
    @ObservedObject static var dataHandler = DataHandler()
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        OverlayView(dataHandler: dataHandler)
            .environmentObject(settings)
    }
}
