//
//  OverlayCompletedView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 8/16/22.
//

import SwiftUI

struct OverlayCompletedView: View {
    @ObservedObject var dataHandler: DataHandler
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        GeometryReader { screen in
            HStack(spacing: 0) {
                VStack {
                    ZStack {
                        RoundedCornersShape(radius: 5, corners: [.topLeft, .topRight])
                            .fill(Color("overlay_completed"))
                            .frame(width: screen.size.width / 1.7, height: 50)
                            .padding(.top)
                            .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 3) - 5) / 2)
                            .padding(.trailing, 5)
                        
                        
                        Text("All \(dataHandler.map.values.compactMap({$0.count}).reduce(0, +)) Advancements Complete!")
                            .font(.custom("Minecraft-Regular", size: 24))
                            .padding(.top)
                            .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 3) - 5) / 2)
                    }
                    
                    ZStack {
                        RoundedCornersShape(radius: 5, corners: [.bottomLeft, .bottomRight])
                            .fill(settings.backgroudColor)
                            .frame(width: screen.size.width / 1.7)
                            .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 3) - 5) / 2)
                            .padding(.top, -8)
                            .padding(.trailing, 5)
                        
                        VStack {
                            Text("Slackow has completed\nMinecraft: Java Edition (\(settings.gameVersion))\nAll Advancements")
                                .font(.custom("Minecraft-Regular", size: 24))
                                .multilineTextAlignment(.center)
                                .frame(width: screen.size.width / 1.7)
                                .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 3) - 5) / 2)
                            
                            Text("\(dataHandler.ticksToIGT(ticks: dataHandler.playTime))\nApproximate IGT")
                                .font(.custom("Minecraft-Regular", size: 24))
                                .multilineTextAlignment(.center)
                                .padding(.top)
                                .frame(width: screen.size.width / 1.7)
                                .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 3) - 5) / 2)
                        }
                    }
                    .padding(.bottom)
                    
                    Spacer()
                }
                
                VStack {
                    ZStack {
                        RoundedCornersShape(radius: 5, corners: [.topLeft, .topRight])
                            .fill(Color("overlay_completed"))
                            .frame(width: screen.size.width / 3, height: 50)
                            .padding(.top)
                        
                        
                        Text("Run Stats")
                            .font(.custom("Minecraft-Regular", size: 24))
                            .padding(.top)
                    }
                    
                    ZStack {
                        RoundedCornersShape(radius: 5, corners: [.bottomLeft, .bottomRight])
                            .fill(settings.backgroudColor)
                            .frame(width: screen.size.width / 3)
                            .padding(.top, -8)
                            .padding(.bottom)
                    }
                    
                    Spacer()
                }
            }
        }
        .background(settings.userOverlayColor)
    }
}

struct OverlayCompletedView_Previews: PreviewProvider {
    @ObservedObject static var dataHandler = DataHandler()
    @StateObject static var settings = AppSettings()
    
    static var previews: some View {
        OverlayCompletedView(dataHandler: dataHandler)
            .frame(width: 785, height: 354)
            .environmentObject(settings)
    }
}
