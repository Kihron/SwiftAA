//
//  Settings.swift
//  SwiftAA
//
//  Created by Kihron on 7/21/22.
//

import SwiftUI

class AppSettings: ObservableObject {
    //Overlay

    
    @AppStorage("overlayWidth") var overlayWidth: Double = 400
    @AppStorage("overlayLoaded") var overlayLoaded: Bool = false
    
    //Player
    @AppStorage("player") var player: Player? = nil
}

