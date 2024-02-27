//
//  CACriteriaTickerTapeView.swift
//  SwiftAA
//
//  Created by Kihron on 2/27/24.
//

import SwiftUI

struct CACriteriaTickerTapeView: View {
    @ObservedObject private var dataManager = DataManager.shared
    @ObservedObject private var overlayManager = OverlayManager.shared
    @State private var containerLayer = CALayer()
    @State private var animationDuration: CFTimeInterval = 10
    @State private var previousCriteria: [Criterion] = []
    private let speedMultiplier: Double = 2
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CALayerHosting(layer: containerLayer)
                    .frame(width: geometry.size.width, height: 40)
                    .onAppear {
                        setupLayers(width: geometry.size.width)
                        startAnimation(width: geometry.size.width)
                    }
                    .onChange(of: dataManager.lastModified) { _ in
                        resetLayers(width: geometry.size.width, override: false)
                    }
                    .onChange(of: TrackerManager.shared.worldPath) { _ in
                        resetLayers(width: geometry.size.width)
                    }
                    .onChange(of: TrackerManager.shared.gameVersion) { _ in
                        resetLayers(width: geometry.size.width)
                    }
                    .onChange(of: TrackerManager.shared.trackingMode) { _ in
                        resetLayers(width: geometry.size.width)
                    }
                    .onChange(of: overlayManager.clarifyAmbigiousCriteria) { _ in
                        resetLayers(width: geometry.size.width)
                    }
                    .onChange(of: geometry.size.width) { width in
                        resetLayers(width: width)
                    }
            }
        }
    }
    
    private func setupLayers(width: CGFloat) {
        containerLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let criteria = dataManager.incompleteCriteria
        guard !criteria.isEmpty else { return } // Ensure criteria is not empty
        
        let itemWidth: CGFloat = 24
        let padding: CGFloat = 10
        let totalItemWidth = itemWidth + padding
        let visibleItemCount = Int(ceil(width / totalItemWidth))
        let totalItemCount = visibleItemCount + criteria.count // Add extra criteria for seamless looping
        
        for i in 0..<totalItemCount {
            let index = i % criteria.count
            let criterion = criteria[index]
            let layer = CALayer()
            layer.contents = NSImage(named: criterion.icon)?.cgImage(forProposedRect: nil, context: nil, hints: nil)
            layer.frame = CGRect(x: CGFloat(i) * totalItemWidth, y: 0, width: itemWidth, height: itemWidth)
            layer.contentsGravity = .resizeAspect
            layer.magnificationFilter = .nearest
            
            if overlayManager.clarifyAmbigiousCriteria && Constants.ambigiousCriteria.contains(criterion.icon),
               let adv = dataManager.getAdvancementForCriteria(criterion: criterion) {
                let overlayLayer = CALayer()
                overlayLayer.contents = NSImage(named: adv.icon)?.cgImage(forProposedRect: nil, context: nil, hints: nil)
                overlayLayer.frame = CGRect(x: -5, y: itemWidth - 12, width: 16, height: 16) // Positioned in the top left corner
                layer.addSublayer(overlayLayer)
            }
            
            containerLayer.addSublayer(layer)
        }
        
        let totalWidth = CGFloat(totalItemCount) * totalItemWidth
        animationDuration = CFTimeInterval(totalWidth / (40 * speedMultiplier))
    }
    
    private func startAnimation(width: CGFloat) {
        guard !dataManager.incompleteCriteria.isEmpty else { return } // Ensure criteria is not empty
        
        let padding: CGFloat = 10
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        let totalItemWidth = 24 + padding
        animation.values = [0, -totalItemWidth * CGFloat(dataManager.incompleteCriteria.count)]
        animation.keyTimes = [0, 1]
        animation.duration = animationDuration
        animation.repeatCount = .infinity
        containerLayer.add(animation, forKey: "tickerAnimation")
    }
    
    private func resetLayers(width: CGFloat, override: Bool = true) {
        let currentCriteria = dataManager.incompleteCriteria
        if currentCriteria != previousCriteria || override {
            containerLayer.removeAllAnimations()
            setupLayers(width: width)
            startAnimation(width: width)
        }
        previousCriteria = currentCriteria
    }
}

#Preview {
    CACriteriaTickerTapeView()
}
