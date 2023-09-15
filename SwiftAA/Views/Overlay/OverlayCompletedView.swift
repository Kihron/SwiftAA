//
//  OverlayCompletedView.swift
//  SwiftAA
//
//  Created by Kihron on 8/16/22.
//

import SwiftUI

struct OverlayCompletedView: View {
    @ObservedObject private var viewModel = MultiPageOverlayViewModel()
    @ObservedObject private var playerManager = PlayerManager.shared
    
    var body: some View {
        GeometryReader { screen in
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    ZStack {
                        RoundedCornersShape(radius: 5, corners: [.topLeft, .topRight])
                            .fill(Color("overlay_completed"))
                            .frame(width: screen.size.width / 1.7, height: 50)
                            .padding(.top)
                            .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 2.5) - 5) / 2)
                            .padding(.trailing, 5)
                        
                        Text(L10n.Overlay.Complete.title(viewModel.totalAdvancements))
                            .font(.custom("Minecraft-Regular", size: 24))
                            .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 2.5) - 5) / 2)
                            .padding(.top, 5)
                    }
                    
                    ZStack {
                        RoundedCornersShape(radius: 5, corners: [.bottomLeft, .bottomRight])
                            .fill(Color("overlay_dark"))
                            .frame(width: screen.size.width / 1.7)
                            .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 2.5) - 5) / 2)
                            .padding(.top, -8)
                            .padding(.trailing, 5)
                        
                        VStack {
                            OverlayShimmerView(message: L10n.Overlay.Complete.message(playerManager.player?.name ?? "Player", TrackerManager.shared.gameVersion.label))
                                .frame(width: screen.size.width / 1.7)
                                .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 2.5) - 5) / 2)
                            
                            OverlayShimmerView(message: L10n.Overlay.Complete.time(viewModel.dataManager.ticksToIGT(ticks: viewModel.dataManager.playTime)))
                                .padding(.top)
                                .frame(width: screen.size.width / 1.7)
                                .padding(.leading, (screen.size.width - (screen.size.width / 1.7 + screen.size.width / 2.5) - 5) / 2)
                        }
                    }
                    .padding(.bottom)
                    
                    Spacer()
                }
                
                VStack(spacing: 0) {
                    ZStack {
                        RoundedCornersShape(radius: 5, corners: [.topLeft, .topRight])
                            .fill(Color("overlay_completed"))
                            .frame(width: screen.size.width / 2.5, height: 50)
                            .padding(.top)
                        
                        
                        Text(L10n.Overlay.Complete.stats)
                            .font(.custom("Minecraft-Regular", size: 24))
                            .padding(.top, 5)
                    }
                    
                    ZStack {
                        RoundedCornersShape(radius: 5, corners: [.bottomLeft, .bottomRight])
                            .fill(Color("overlay_dark"))
                            .frame(width: screen.size.width / 2.5)
                            .padding(.top, -8)
                            .padding(.bottom)
                        
                        LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 32), spacing: 2, alignment: .leading), count: 3), spacing: 10) {
                            let array = viewModel.getStatsArray()
                            ForEach(array.indices, id: \.self) { index in
                                array[index]
                            }
                        }
                        .padding(.top)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 15)
    }
}

struct OverlayCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayCompletedView()
            .frame(width: 820, height: 345)
    }
}
