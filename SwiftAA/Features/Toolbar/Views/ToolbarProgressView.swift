//
//  ToolbarAAView.swift
//  SwiftAA
//
//  Created by Kihron on 7/22/22.
//

import SwiftUI

struct ToolbarProgressView: View {
    @Access(\.advancementManager) private var advancementManager
    
    @ObservedObject private var progressManager = ProgressManager.shared
    @ObservedObject private var trackerManager = TrackerManager.shared
    
    var body: some View {
        ProgressBarView(value: .constant(advancementManager.completedAdvancements.count), total: .constant(advancementManager.allAdvancements.count), title: L10n.Goal.advancements, message: .constant("\(trackerManager.getInstanceNumber())IGT: \(progressManager.getInGameTime())"), isToolbar: true)
            .frame(width: 280)
    }
}

struct ToolbarProgressView_Previews: PreviewProvider {
    static var dataManager = DataManager.shared
    
    static var previews: some View {
        ToolbarProgressView()
    }
}
