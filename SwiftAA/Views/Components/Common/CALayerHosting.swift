//
//  CALayerHosting.swift
//  SwiftAA
//
//  Created by Kihron on 2/27/24.
//

import SwiftUI

struct CALayerHosting: NSViewRepresentable {
    var layer: CALayer
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        view.wantsLayer = true
        view.layer = layer
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        nsView.layer = layer
    }
}
