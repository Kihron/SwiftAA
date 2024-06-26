//
//  ToolbarAlert.swift
//  SwiftAA
//
//  Created by Kihron on 7/22/22.
//

import SwiftUI

struct ToolbarAlertView: View {
    @ObservedObject private var trackerManager = TrackerManager.shared
    @State private var showPopover: Bool = false
    let tips: [TrackerAlert] = [.enterMinecraft]
    
    var body: some View {
        VStack {
            if let error = trackerManager.alert {
                Button {
                    showPopover.toggle()
                } label: {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(tips.contains(error) ? .blue : .red)
                }
                .popover(isPresented: self.$showPopover, arrowEdge: .bottom) {
                    PopoverView(error: error.description)
                }
                .buttonStyle(.plain)
                .frame(width: 32, height: 32)
                .transition(.scale.combined(with: .opacity))
                .onAppear {
                    LayoutManager.shared.infoMode = false
                }
            } else {
                ToolbarInfoView()
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.linear(duration: 0.2), value: trackerManager.alert)
    }
}

struct PopoverView: View {
    @State var error: String
    
    var body: some View {
        VStack {
            Text(error.localized)
                .padding()
        }
    }
}

struct ToolbarAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarAlertView()
            .frame(width: 50, height: 50)
    }
}
