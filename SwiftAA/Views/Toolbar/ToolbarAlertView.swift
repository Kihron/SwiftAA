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
        if let error = trackerManager.alert {
            Button {
                showPopover.toggle()
            } label: {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 15))
                    .foregroundColor(tips.contains(error) ? .blue : .red)
            }
            .popover(isPresented: self.$showPopover, arrowEdge: .bottom) {
                PopoverView(error: error.description)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 5)
        }
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
