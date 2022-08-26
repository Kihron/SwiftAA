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
        ProgressBarView(value: .constant($dataHandler.map.values.flatMap({$0}).filter({$0.completed.wrappedValue}).count), total: .constant($dataHandler.map.values.compactMap({$0.count}).reduce(0, +)), title: "goal-advancements".localized, message: .constant("      IGT: \(dataHandler.ticksToIGT(ticks: dataHandler.playTime))"), isToolbar: true)
            .frame(width: 300)
    }
}

struct ToolbarAAView_Previews: PreviewProvider {
    static var dataHandler = DataHandler()
    
    static var previews: some View {
        ToolbarAAView(dataHandler: dataHandler, changed: .constant(false))
    }
}
