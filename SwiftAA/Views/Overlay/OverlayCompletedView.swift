//
//  OverlayCompletedView.swift
//  SwiftAA
//
//  Created by Kihron on 8/16/22.
//

import SwiftUI

struct OverlayCompletedView: View {
    @Access(\.progressManager) private var progressManager
    @AppSettings(\.tracker.player) private var player

    @ObservedObject private var dataManager = DataManager.shared

    var body: some View {
        HStack {
            VStack {
                ZStack {
                    Group {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color("overlay_dark"))
                        
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.4), lineWidth: 1)
                    }
                    .padding(1)
                    
                    ZStack {
                        Group {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color("overlay_completed"))
                            
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 0.5)
                        }
                        .frame(height: 50)
                        .shadow(color: .black, radius: 10)
                        .mask(RoundedRectangle(cornerRadius: 5).padding(.bottom, -25))
                        
                        Text(L10n.Overlay.Complete.title(dataManager.allAdvancements.count))
                            .minecraftFont(size: 24)
                            .shadow(color: .black, radius: 1, x: 2, y: 2)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    
                    VStack {
                        OverlayShimmerView(message: L10n.Overlay.Complete.message(player?.name ?? "Player", TrackerManager.shared.gameVersion.label))
                        
                        OverlayShimmerView(message: L10n.Overlay.Complete.time(progressManager.getInGameTime()))
                            .padding(.top)
                    }
                    .padding(.top, 40)
                }
                .frame(width: 550)
                .padding(.vertical, 20)
            }
            
            VStack {
                ZStack {
                    Group {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color("overlay_dark"))
                        
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.4), lineWidth: 1)
                    }
                    .padding(1)
                    
                    ZStack {
                        Group {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color("overlay_completed"))
                            
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 0.5)
                        }
                        .frame(height: 50)
                        .shadow(color: .black, radius: 10)
                        .mask(RoundedRectangle(cornerRadius: 5).padding(.bottom, -25))
                        
                        Text(L10n.Overlay.Complete.stats)
                            .minecraftFont(size: 24)
                            .shadow(color: .black, radius: 1, x: 2, y: 2)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    
                    LazyHGrid(rows: Array(repeating: GridItem(.adaptive(minimum: 32), spacing: 0, alignment: .leading), count: 5), spacing: 20) {
                        ForEach(Constants.finalStatistics) { statistic in
                            FinalStatsView(statistic: statistic)
                        }
                    }
                    .padding(.top, 60)
                    .padding(.bottom)
                }
                .padding(.vertical, 20)
            }
        }
        .padding(.horizontal, 15)
    }
}

struct OverlayCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayCompletedView()
            .frame(width: 820, height: 300)
    }
}
