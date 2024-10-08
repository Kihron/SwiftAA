//
//  ToolbarAAView.swift
//  SwiftAA
//
//  Created by Kihron on 7/22/22.
//

import SwiftUI

struct ToolbarProgressView: View {
    @ObservedObject private var dataManager = DataManager.shared
    @ObservedObject private var progressManager = ProgressManager.shared
    @ObservedObject private var trackerManager = TrackerManager.shared
    
    var body: some View {
        ProgressBarView(value: .constant(dataManager.completedAdvancements.count), total: .constant(dataManager.allAdvancements.count), title: L10n.Goal.advancements, message: .constant("\(trackerManager.getInstanceNumber())IGT: \(progressManager.getInGameTime())"), isToolbar: true)
            .frame(width: 280)
    }
}

struct ToolbarProgressView_Previews: PreviewProvider {
    static var dataManager = DataManager.shared
    
    static var previews: some View {
        ToolbarProgressView()
    }
}
