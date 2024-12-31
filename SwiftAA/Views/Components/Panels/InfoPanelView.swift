//
//  InfoPanelView.swift
//  SwiftAA
//
//  Created by Kihron on 7/23/22.
//

import SwiftUI

struct InfoPanelView: View {
    @ObservedObject private var layoutManager = LayoutManager.shared

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if (layoutManager.isNotes) {
                NotesPanelView()
            } else {
                Group {
                    switch layoutManager.modularPanel {
                        case .leaderboard:
                            LeaderboardPanelView()
                        case .potionPanel:
                            PotionPanelView()
                    }
                }
                .frame(maxHeight: 514)
            }
            
            Button {
                withAnimation {
                    layoutManager.isNotes.toggle()
                }
            } label: {
                Image(systemName: "arrow.counterclockwise.circle")
                    .font(.system(size: 14))
                    .applyThemeText()
                    .frame(width: 32, height: 32)
                    .padding(4)
            }
            .buttonStyle(.plain)
            .frame(width: 32, height: 32)
        }
        .animation(.linear, value: layoutManager.isNotes)
        .animation(.easeInOut, value: layoutManager.modularPanel)
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView()
            .frame(width: 300, height: 800)
    }
}
