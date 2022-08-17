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
                    Label("settings-tracking", systemImage: "slider.horizontal.3")
                }
            ThemeSettingsView()
                .tabItem {
                    Label("settings-theme", systemImage: "paintpalette")
                }
            OverlaySettingsView()
                .tabItem {
                    Label("settings-overlay", systemImage: "ipad.landscape")
                }
            NotesSettingsView()
                .tabItem {
                    Label("settings-notes", systemImage: "rectangle.and.pencil.and.ellipsis")
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
