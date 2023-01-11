//
//  ToolbarAAView.swift
//  SwiftAA
//
//  Created by Kihron on 7/22/22.
//

import SwiftUI

struct ToolbarAAView: View {
    @ObservedObject var dataHandler: DataHandler
    @Binding var changed: Bool
    
    var body: some View {
        ProgressBarView(value: .constant(dataHandler.completedAdvancements), total: .constant(dataHandler.totalAdvancements), title: L10n.Goal.advancements, message: .constant("      IGT: \(dataHandler.ticksToIGT(ticks: dataHandler.playTime))"), isToolbar: true)
            .frame(width: 300)
    }
}

struct ToolbarAAView_Previews: PreviewProvider {
    static var dataHandler = DataHandler()
    
    static var previews: some View {
        ToolbarAAView(dataHandler: dataHandler, changed: .constant(false))
    }
}
