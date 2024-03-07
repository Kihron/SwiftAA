//
//  IndicatorLayer.swift
//  SwiftAA
//
//  Created by Kihron on 2/27/24.
//

import SwiftUI

class IndicatorLayer: CALayer {
    var indicator: Indicator
    
    init(indicator: Indicator) {
        self.indicator = indicator
        super.init()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayer() {
        // Set the size of the indicator layer
        self.bounds = CGRect(x: 0, y: 0, width: 74, height: 74)
        
        // Add the frame layer
        let frameLayer = CALayer()
        frameLayer.frame = CGRect(x: 6, y: 6, width: 52, height: 52).integral
        frameLayer.contents = frameImage(for: indicator).cgImage(forProposedRect: nil, context: nil, hints: nil)
        frameLayer.magnificationFilter = .nearest
        self.addSublayer(frameLayer)
        
        // Add the icon layer
        if Constants.animatedIcons.contains(indicator.icon) {
            let iconLayer = AnimatedIconLayer(icon: indicator.icon)
            iconLayer.frame = CGRect(x: 16, y: 16, width: 32, height: 32).integral
            self.addSublayer(iconLayer)
        } else {
            let iconLayer = CALayer()
            iconLayer.frame = CGRect(x: 16, y: 16, width: 32, height: 32).integral
            iconLayer.contents = NSImage(named: indicator.icon)?.cgImage(forProposedRect: nil, context: nil, hints: nil)
            iconLayer.contentsGravity = .resizeAspect
            iconLayer.magnificationFilter = .nearest
            self.addSublayer(iconLayer)
        }
        
        // Add the name label
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: -6, y: -26, width: 74, height: 26).integral // Position below the icon, increase height for wrapping
        textLayer.string = indicator.key.localized
        textLayer.fontSize = 10
        textLayer.alignmentMode = .center
        textLayer.foregroundColor = NSColor.white.cgColor
        textLayer.contentsScale = NSScreen.main?.backingScaleFactor ?? 1.0
        textLayer.isWrapped = true // Enable text wrapping
        textLayer.truncationMode = .end // Truncate at the end if text is too long
        
        // Set custom font
        let font = CTFontCreateWithName("minecraft-regular" as CFString, 10, nil)
        textLayer.font = font
        textLayer.fontSize = CTFontGetSize(font)
        
        self.addSublayer(textLayer)
    }
    
    private func frameImage(for indicator: Indicator) -> NSImage {
        let frameStyle = indicator.frameStyle
        let size = NSSize(width: 52, height: 52)
        let image = NSImage(size: size)
        
        image.lockFocus()
        
        switch OverlayManager.shared.overlayFrameStyle {
            case .minecraft:
                let imageName = "frame_mc_\(frameStyle)_incomplete"
                NSImage(named: imageName)?.draw(in: NSRect(origin: .zero, size: size))
                
            case .geode:
                if let backImage = NSImage(named: "frame_geode_back") {
                    backImage.draw(in: NSRect(origin: .zero, size: size))
                }
                if let borderImage = NSImage(named: "frame_geode_border") {
                    borderImage.draw(in: NSRect(origin: .zero, size: size))
                }
                
            case .modern:
                if let backImage = NSImage(named: "frame_modern_back")?.tinted(with: NSColor(named: "frame_modern_background") ?? .clear) {
                    backImage.draw(in: NSRect(origin: .zero, size: size))
                }
                if let borderImage = NSImage(named: "frame_modern_border")?.tinted(with: .gray) {
                    borderImage.draw(in: NSRect(origin: .zero, size: size))
                }
        }
        
        image.unlockFocus()
        return image
    }
}
