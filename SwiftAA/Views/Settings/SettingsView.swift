//
//  SettingsView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/21/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        TabView {
            TrackingSettingsView()
                 .tabItem {
                     Label("Tracking", systemImage: "slider.horizontal.3")
                 }
            ThemeSettingsView()
                 .tabItem {
                     Label("Theme", systemImage: "paintpalette")
                 }
            NotesSettingsView()
                .tabItem {
                    Label("Notes", systemImage: "rectangle.and.pencil.and.ellipsis")
                }
         }
         .frame(width: 450, height: 250)
         .environmentObject(settings)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
