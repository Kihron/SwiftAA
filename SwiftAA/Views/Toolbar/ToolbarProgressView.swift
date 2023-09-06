//
//  ToolbarAAView.swift
//  SwiftAA
//
//  Created by Kihron on 7/22/22.
//

import SwiftUI

struct ToolbarProgressView: View {
    @ObservedObject var dataHandler: DataHandler
    
    var body: some View {
        ProgressBarView(value: .constant(dataHandler.completedAdvancements), total: .constant(dataHandler.totalAdvancements), title: L10n.Goal.advancements, message: .constant("      IGT: \(dataHandler.ticksToIGT(ticks: dataHandler.playTime))"), isToolbar: true)
            .frame(width: 300)
    }
}

struct ToolbarProgressView_Previews: PreviewProvider {
    static var dataHandler = DataHandler()
    
    static var previews: some View {
        ToolbarProgressView(dataHandler: dataHandler)
    }
}
