//
//  ToolbarAlert.swift
//  SwiftAA
//
//  Created by Kihron on 7/22/22.
//

import SwiftUI

struct ToolbarAlertView: View {
    @Binding var error: String
    @State var showPopover: Bool = false
    let tips = ["error-enter-minecraft"]
    
    var body: some View {
        Button {
            showPopover.toggle()
        } label: {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 15))
                .foregroundColor(tips.contains(error) ? .blue : .red)
        }
        .popover(isPresented: self.$showPopover, arrowEdge: .bottom) {
            PopoverView(error: $error)
        }
        .buttonStyle(.plain)
        .padding(.trailing, 5)
    }
}

struct PopoverView: View {
    @Binding var error: String
    
    var body: some View {
        VStack {
            Text(error.localized)
                .padding()
        }
    }
}

struct ToolbarAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarAlertView(error: .constant("No Directory Selected"), showPopover: false)
            .frame(width: 50, height: 50)
    }
}
