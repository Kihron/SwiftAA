//
//  IndicatorTickerTapeViewModel.swift
//  SwiftAA
//
//  Created by Kihron on 2/27/24.
//

import SwiftUI

class IndicatorTickerTapeViewModel: ObservableObject {
    @ObservedObject private var overlayManager = OverlayManager.shared
    @ObservedObject private var dataManager = DataManager.shared
    
    @Published var containerLayer = CALayer()
    
    private var animationDuration: CFTimeInterval = 0
    private var previousIndicators: [Advancement] = []
    private var debounceWorkItem: DispatchWorkItem?
    
    init() {
        
    }
    
    func setupLayers(width: CGFloat) {
        containerLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let indicators = dataManager.incompleteAdvancements.isEmpty ? dataManager.allAdvancements : dataManager.incompleteAdvancements
        guard !indicators.isEmpty else { return }
        
        let itemWidth: CGFloat = 74
        let padding: CGFloat = 4
        let totalItemWidth = itemWidth + padding
        let visibleItemCount = Int(ceil(width / totalItemWidth))
        let totalItemCount = max(visibleItemCount, indicators.count) * 2 // Ensure enough items for continuous scrolling
        
        for i in 0..<totalItemCount {
            let index = i % indicators.count
            let indicator = indicators[index]
            let layer = IndicatorLayer(indicator: indicator)
            layer.frame = CGRect(x: CGFloat(i) * totalItemWidth, y: 0, width: itemWidth, height: itemWidth)
            containerLayer.addSublayer(layer)
        }
        
        animationDuration = CFTimeInterval((totalItemWidth * CGFloat(indicators.count)) / overlayManager.tickerTapeSpeed)
    }
    
    func startAnimation(width: CGFloat) {
        let indicators = dataManager.incompleteAdvancements.isEmpty ? dataManager.allAdvancements : dataManager.incompleteAdvancements
        guard !indicators.isEmpty else { return }
        
        let padding: CGFloat = 4
        let animation = CABasicAnimation(keyPath: "position.x")
        let totalItemWidth = 74 + padding
        let distance = -totalItemWidth * CGFloat(indicators.count) // Distance for one set of items
        
        animation.fromValue = overlayManager.invertScrollDirection ? distance : 0
        animation.toValue = overlayManager.invertScrollDirection ? 0 : distance
        animation.duration = animationDuration
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        // Adjust the begin time to maintain continuity
        let currentPresentationLayer = containerLayer.presentation()
        let currentOffset = currentPresentationLayer?.position.x ?? 0
        let adjustedOffset = overlayManager.invertScrollDirection ? distance - currentOffset : currentOffset
        var elapsed = CGFloat(adjustedOffset / distance) * CGFloat(animationDuration)
        
        // Ensure elapsed time is within a valid range
        elapsed = max(0, min(elapsed, CGFloat(animationDuration)))
        animation.beginTime = CACurrentMediaTime() - CFTimeInterval(elapsed)
        
        containerLayer.add(animation, forKey: "tickerAnimation")
    }
    
    func resetLayers(width: CGFloat, override: Bool = true) {
        guard !dataManager.completedAllAdvancements else { return }
        let currentIndicators = dataManager.incompleteAdvancements.isEmpty ? dataManager.allAdvancements : dataManager.incompleteAdvancements
        
        if currentIndicators != previousIndicators || override {
            // Begin a transaction to update the layers without animation
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            
            containerLayer.removeAllAnimations()
            setupLayers(width: width)
            
            CATransaction.commit()
            startAnimation(width: width)
            previousIndicators = currentIndicators
        }
    }
    
    func debounceResetLayers(width: CGFloat, override: Bool = true) {
        debounceWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            self.resetLayers(width: width)
        }
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
    }
}
