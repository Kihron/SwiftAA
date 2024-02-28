//
//  NSImage+Ext.swift
//  SwiftAA
//
//  Created by Kihron on 2/27/24.
//

import SwiftUI

extension NSImage {
    func tinted(with color: NSColor) -> NSImage {
        let image = self.copy() as! NSImage
        image.lockFocus()
        color.set()
        NSRect(origin: .zero, size: self.size).fill(using: .sourceAtop)
        image.unlockFocus()
        return image
    }
}
