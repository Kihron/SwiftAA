//
//  SettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI
import SwiftUIIntrospect

struct SettingsView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @ObservedObject private var layoutManager = LayoutManager.shared
    
    @State private var sideBarVisibility: NavigationSplitViewVisibility = .doubleColumn
    @State private var selectedSettingsBarItem: SettingsBarItem = .tracking
    @State private var disableCollapse: Bool = false
    
    private var tintColor: Color {
        return layoutManager.matchThemeColor ? themeManager.border : .accentColor
    }
    
    var body: some View {
        NavigationSplitView(columnVisibility: $sideBarVisibility) {
            VStack {
                List(SettingsBarItem.allCases, selection: $selectedSettingsBarItem) { item in
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
                    }
                    .frame(height: 20)
                    .padding(.vertical, 5)
                    .contentShape(Rectangle())
                    .listRowBackground(Group {
                        if selectedSettingsBarItem == item {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(tintColor)
                                .opacity(0.8)
                                .padding(.horizontal, 10)
                        }
                    })
                }
                .frame(width: 200)
                .removeSidebar()
                .introspect(.list, on: .macOS(.v13, .v14)) { listView in
                    DispatchQueue.main.async {
                        listView.selectionHighlightStyle = .none
                    }
                }
                
                SettingsAccountView()
            }
        } detail: {
            Group {
                switch selectedSettingsBarItem {
                    case .tracking:
                        TrackingSettingsView()
                    case .layout:
                        LayoutSettingsView()
                    case .theme:
                        ThemeSettingsView()
                    case .overlay:
                        OverlaySettings()
                    case .notes:
                        NotesSettingsView()
                    case .updates:
                        UpdateSettings()
                    case .credits:
                        CreditsView()
                }
            }
            .tint(tintColor)
        }
    }
}

#Preview {
    SettingsView()
}
