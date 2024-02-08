//
//  SettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 9/5/23.
//

import SwiftUI
import SwiftUIIntrospect

struct SettingsView: View {
    @State private var sideBarVisibility: NavigationSplitViewVisibility = .doubleColumn
    @State private var selectedSettingsBarItem: SettingsBarItem = .tracking
    @State private var disableCollapse: Bool = false
    
    var body: some View {
        NavigationSplitView(columnVisibility: $sideBarVisibility) {
            VStack {
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
                .removeSidebar()
                
                SettingsAccountView()
            }
        } detail: {
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
            }
        }
    }
}

//extension View {
//    func preventSidebarCollapse() -> some View {
//        return introspect(.navigationSplitView, on: .macOS(.v13, .v14)) { splitView in
//            if let delegate = (splitView.delegate as? NSSplitViewController) {
//                delegate.splitViewItems.first?.canCollapse = false
//                delegate.splitViewItems.first?.maximumThickness = 200
//                delegate.splitViewItems.first?.minimumThickness = 200
//            }
//        }
//    }
//}

#Preview {
    SettingsView()
}
