//
//  InfoPanelView.swift
//  SwiftAA
//
//  Created by Kihron on 7/23/22.
//

import SwiftUI

struct InfoPanelView: View {
    @AppStorage("wasLastNotes") private var isNotes: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if (isNotes) {
                NotesPanelView()
            } else {
//                PotionPanelView()
                LeaderboardPanelView()
                    .frame(height: 431)
            }
            
            Button {
                withAnimation {
                    isNotes.toggle()
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
            .padding(0)
        }
        .animation(.linear, value: isNotes)
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView()
            .frame(width: 300, height: 800)
    }
}
