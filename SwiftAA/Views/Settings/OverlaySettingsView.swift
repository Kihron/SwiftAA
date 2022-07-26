//
//  OverlaySettingsView.swift
//  SwiftAA
//
//  Created by Kihron on 8/15/22.
//

import SwiftUI

struct OverlaySettingsView: View {
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                HStack{
                    Text("overlay-stat-row-pos")
                        .font(.custom("Minecraft-Regular", size: 10))
                    
                    Menu {
                        Button {
                            withAnimation(.spring()) {
                                settings.statsRowPos = true
                            }
                        } label: {
                            Text("overlay-stat-row-pos-left")
                                .font(.custom("Minecraft-Regular", size: 10))
                        }
                        Button {
                            withAnimation(.spring()) {
                                settings.statsRowPos = false
                            }
                        } label: {
                            Text("overlay-stat-row-pos-right")
                                .font(.custom("Minecraft-Regular", size: 10))
                        }
                    } label: {
                        Text(settings.statsRowPos ? "overlay-stat-row-pos-left" : "overlay-stat-row-pos-right")
                            .font(.custom("Minecraft-Regular", size: 10))
                    }
                    .frame(width: 75)
                }
                
                Spacer()

            }
            
            Spacer()
        }
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
