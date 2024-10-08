//
//  L1_19.swift
//  SwiftAA
//
//  Created by Kihron on 8/22/22.
//

import SwiftUI

struct L1_19: View {
    @ObservedObject private var trackerManager = TrackerManager.shared
    
    var body: some View {
        if trackerManager.gameVersion == .v1_19 {
            L1_19S()
        }
    }
}

struct L1_19_Previews: PreviewProvider {
    static var previews: some View {
        L1_19()
            .frame(width: 1702, height: 754)
    }
}
