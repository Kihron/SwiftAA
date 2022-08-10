//
//  ToolbarAAView.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/22/22.
//

import SwiftUI

struct ToolbarAAView: View {
    @Binding var map: [String:[Advancement]]
    @Binding var playTime: Int
    @Binding var changed: Bool
    
    var body: some View {
        ProgressBarView(value: .constant($map.values.flatMap({$0}).filter({$0.completed.wrappedValue}).count), total: $map.values.compactMap({$0.count}).reduce(0, +), title: "goal-advancements".localized, message: .constant("      IGT: \(ticksToIGT(ticks: $playTime.wrappedValue))"))
            .frame(width: 300)
    }
    
    func ticksToIGT(ticks: Int) -> String {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.hour, .minute, .second]
        dateFormatter.unitsStyle = .positional
        dateFormatter.zeroFormattingBehavior = .pad
        return dateFormatter.string(from: Double(ticks / 20)) ?? "0:00:00"
    }
}

struct ToolbarAAView_Previews: PreviewProvider {
    static var dataHandler = DataHandler()
    
    static var previews: some View {
        ToolbarAAView(map: .constant(dataHandler.map), playTime: .constant(0), changed: .constant(false))
    }
}
