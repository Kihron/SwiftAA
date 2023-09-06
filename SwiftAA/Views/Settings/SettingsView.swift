//
//  SettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 7/21/22.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var dataManager: DataManager
    @EnvironmentObject var settings: AppSettings
    @ObservedObject var updater: Updater
    
    var body: some View {
        TabView {
            TrackingSettingsView(dataManager: dataManager)
                .tabItem {
                    Label(L10n.Settings.tracking, systemImage: "slider.horizontal.3")
                }
            ThemeSettingsView()
                .tabItem {
                    Label(L10n.Settings.theme, systemImage: "paintpalette")
                }
            OverlaySettingsView()
                .tabItem {
                    Label(L10n.Settings.overlay, systemImage: "ipad.landscape")
                }
            NotesSettingsView()
                .tabItem {
                    Label(L10n.Settings.notes, systemImage: "rectangle.and.pencil.and.ellipsis")
                }
            UpdateSettingsView(updater: updater)
                .tabItem {
                    Label(L10n.Settings.updater, systemImage: "square.and.arrow.down")
                }
        }
        .frame(width: 450, height: 250)
    }
}

struct SettingsView_Previews: PreviewProvider {
    @ObservedObject static var dataManager = DataManager()
    @ObservedObject static var updater = Updater()
    
    static var previews: some View {
        SettingsView(dataManager: dataManager, updater: updater)
    }
}
