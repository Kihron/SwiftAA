//
//  BlurEffect.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 8/27/22.
//

import SwiftUI

class TransparentView: NSView {
  override func viewDidMoveToWindow() {
      window?.titlebarAppearsTransparent = false
      window?.backgroundColor = .init(white: 0, alpha: 0.0001)
      window?.titlebarAppearsTransparent = false
      super.viewDidMoveToWindow()
  }
}

struct TransparentWindow: NSViewRepresentable {
   func makeNSView(context: Self.Context) -> NSView { return TransparentView() }
   func updateNSView(_ nsView: NSView, context: Context) { }
}
