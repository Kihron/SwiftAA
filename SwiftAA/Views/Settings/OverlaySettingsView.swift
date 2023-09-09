//
//  OverlaySettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 8/15/22.
//

import SwiftUI

struct OverlaySettingsView: View {
    @EnvironmentObject var settings: AppSettings
    @ObservedObject private var overlayManager = OverlayManager.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                HStack{
                    Text(L10n.Overlay.Stat.Row.pos)
                        .font(.custom("Minecraft-Regular", size: 10))
                    
                    Menu {
                        Button {
                            withAnimation(.spring()) {
                                overlayManager.statisticsAlignment = .leading
                            }
                        } label: {
                            Text(L10n.Overlay.Stat.Row.Pos.left)
                                .font(.custom("Minecraft-Regular", size: 10))
                        }
                        Button {
                            withAnimation(.spring()) {
                                overlayManager.statisticsAlignment = .trailing
                            }
                        } label: {
                            Text(L10n.Overlay.Stat.Row.Pos.right)
                                .font(.custom("Minecraft-Regular", size: 10))
                        }
                    } label: {
                        Text(overlayManager.statisticsAlignment == .leading ? L10n.Overlay.Stat.Row.Pos.left : L10n.Overlay.Stat.Row.Pos.right)
                            .font(.custom("Minecraft-Regular", size: 10))
                    }
                    .frame(width: 75)
                }
                .padding(.trailing)
                
                HStack {
                    Text(L10n.Overlay.bar)
                        .font(.custom("Minecraft-Regular", size: 10))
                    
                    Toggle("", isOn: $overlayManager.showLegacyPageBar)
                }
                
                Spacer()
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct OverlaySettingsView_Previews: PreviewProvider {
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        OverlaySettingsView()
            .frame(width: 450, height: 250)
            .environmentObject(settings)
    }
}
