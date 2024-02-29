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
    
    private var instName: String {
        if trackerManager.trackingMode == .seamless {
            let saves = trackerManager.lastWorking
            if !saves.isEmpty {
                let paths = saves.split(separator: "/")
                if paths.count >= 3 {
                    print("lol: \(saves)")
                    let res = paths[paths.count - 3].suffix(2)
                    if res.count >= 2 {
                        return "(\(String(res.first!.isNumber ? res : res.suffix(1)))) "
                    }
                }
            }
        }
        return ""
    }
    
    var body: some View {
        ProgressBarView(value: .constant(dataManager.completedAdvancements.count), total: .constant(dataManager.allAdvancements.count), title: L10n.Goal.advancements, message: .constant("\(instName)IGT: \(progressManager.getInGameTime())"), isToolbar: true)
            .frame(width: 280)
    }
}

struct ToolbarProgressView_Previews: PreviewProvider {
    static var dataManager = DataManager.shared
    
    static var previews: some View {
        ToolbarProgressView()
    }
}
