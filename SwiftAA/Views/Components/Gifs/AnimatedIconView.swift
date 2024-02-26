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
        
        let layer = CALayer()
        layer.contentsGravity = .resizeAspect
        layer.magnificationFilter = .nearest
        view.layer = layer
        
        if let (frames, durations) = framesAndDurations(withIcon: icon) {
            let animation = CAKeyframeAnimation(keyPath: "contents")
            animation.values = frames.map { $0.cgImage(forProposedRect: nil, context: nil, hints: nil)! }
            animation.keyTimes = durations.enumerated().map { (index, duration) in
                return NSNumber(value: durations[0..<index].reduce(0, +) / durations.reduce(0, +))
            }
            animation.duration = durations.reduce(0, +) / speedMultiplier
            animation.repeatCount = .infinity
            layer.add(animation, forKey: "frameAnimation")
        }
        
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        // Update the view if necessary.
    }
    
    private func framesAndDurations(withIcon icon: String) -> (frames: [NSImage], durations: [TimeInterval])? {
        if let cachedData = Constants.gifCache[icon] {
            return cachedData
        }
        
        guard let gifURL = Bundle.main.url(forResource: icon, withExtension: "gif"), let gifData = try? Data(contentsOf: gifURL) else {
            return nil
        }
        
        guard let source = CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var frames: [NSImage] = []
        var durations: [TimeInterval] = []
        
        let count = CGImageSourceGetCount(source)
        for i in 0..<count {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }
            frames.append(NSImage(cgImage: cgImage, size: .zero))
            
            if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any],
               let gifProperties = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any],
               let delayTime = gifProperties[kCGImagePropertyGIFDelayTime as String] as? TimeInterval {
                durations.append(delayTime)
            } else {
                durations.append(0.1)
            }
        }
        
        let result = (frames, durations)
        Constants.gifCache[icon] = result
        return result
    }
}
