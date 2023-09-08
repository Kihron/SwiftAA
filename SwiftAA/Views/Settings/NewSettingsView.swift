//
//  NewSettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI

struct NewSettingsView: View {
    @State var sideBarVisibility: NavigationSplitViewVisibility = .doubleColumn
    @State var selectedSettingsBarItem: SettingsBarItem = .tracking
    
    var body: some View {
        NavigationSplitView(columnVisibility: $sideBarVisibility) {
            List(SettingsBarItem.allCases, selection: $selectedSettingsBarItem) { item in
                NavigationLink(value: item) {
                    HStack(alignment: .center, spacing: 10) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(item.color.gradient)
                                .frame(width: 25, height: 25)
                            
                            Image(systemName: item.icon)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 20, alignment: .center)
                        }
                        
                        Text(item.label.localized)
                            .tint(.primary)
                    }
                    .frame(height: 20)
                    .padding(.vertical, 5)
                    .contentShape(Rectangle())
                }
            }
            .frame(width: 200)
        } detail: {
            switch selectedSettingsBarItem {
                case .tracking:
                    NewTrackingSettingsView()
                case .theme:
                    NewThemeSettingsView()
                case .overlay:
                    Text(selectedSettingsBarItem.label.localized)
                case .notes:
                    Text(selectedSettingsBarItem.label.localized)
                case .updates:
                    NewUpdateSettings()
            }
        }
    }
}

#Preview {
    NewSettingsView()
}
