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
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        let totalItemWidth = 74 + padding
        let distance = -totalItemWidth * CGFloat(indicators.count) // Distance for one set of items
        
        animation.values = overlayManager.invertScrollDirection ? [distance, 0] : [0, distance]
        animation.keyTimes = [0, 1]
        animation.duration = animationDuration
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        containerLayer.add(animation, forKey: "tickerAnimation")
    }
    
    func resetLayers(width: CGFloat, override: Bool = true) {
        let currentIndicators = dataManager.incompleteAdvancements.isEmpty ? dataManager.allAdvancements : dataManager.incompleteAdvancements
        if currentIndicators != previousIndicators || override {
            containerLayer.removeAllAnimations()
            setupLayers(width: width)
            startAnimation(width: width)
        }
        previousIndicators = currentIndicators
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
