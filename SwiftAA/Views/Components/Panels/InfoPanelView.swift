//
//  InfoPanelView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/23/22.
//

import SwiftUI

struct InfoPanelView: View {
    @State var isNotes = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if (isNotes) {
                NotesPanelView()
            } else {
                PotionPanelView()
            }
            
            Button {
                withAnimation {
                    isNotes.toggle()
                }
            } label: {
                Image(systemName: "arrow.counterclockwise.circle")
                    .font(.system(size: 14))
                    .frame(width: 32, height: 32)
                    .padding(4)
            }
            .buttonStyle(.plain)
            .frame(width: 32, height: 32)
            .padding(0)
        }
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView()
            .frame(width: 300, height: 800)
    }
}