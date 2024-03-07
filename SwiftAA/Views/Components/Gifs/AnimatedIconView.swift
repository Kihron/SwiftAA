//
//  AnimatedIconView.swift
//  SwiftAA
//
//  Created by Kihron on 2/25/24.
//

import SwiftUI

struct AnimatedIconView: NSViewRepresentable {
    var icon: String
    var speedMultiplier: Double = 1.0
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        view.wantsLayer = true
        
        let layer = AnimatedIconLayer(icon: icon, speedMultiplier: speedMultiplier)
        view.layer = layer
        
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        // Update the view if necessary.
    }
}
