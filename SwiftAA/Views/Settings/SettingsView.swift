//
//  SettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 7/21/22.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var dataHandler: DataHandler
    @EnvironmentObject var settings: AppSettings
    @ObservedObject var updater: Updater
    
    var body: some View {
        TabView {
            TrackingSettingsView(dataHandler: dataHandler)
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
            UpdateSettingsView(updater: updater)
                .tabItem {
                    Label("settings-updater", systemImage: "square.and.arrow.down")
                }
        }
        .frame(width: 450, height: 250)
    }
}

struct SettingsView_Previews: PreviewProvider {
    @ObservedObject static var dataHandler = DataHandler()
    @ObservedObject static var updater = Updater()
    
    static var previews: some View {
        SettingsView(dataHandler: dataHandler, updater: updater)
    }
}
