//
//  ToolbarAAView.swift
//  SwiftAA
//
//  Created by Kihron on 7/22/22.
//

import SwiftUI

struct ToolbarProgressView: View {
    @ObservedObject var dataManager = DataManager.shared
    
    var body: some View {
        ProgressBarView(value: .constant(dataManager.completedAdvancements), total: .constant(dataManager.totalAdvancements), title: L10n.Goal.advancements, message: .constant("      IGT: \(dataManager.ticksToIGT(ticks: dataManager.playTime))"), isToolbar: true)
            .frame(width: 300)
    }
}

struct ToolbarProgressView_Previews: PreviewProvider {
    static var dataManager = DataManager.shared
    
    static var previews: some View {
        ToolbarProgressView(dataManager: dataManager)
    }
}