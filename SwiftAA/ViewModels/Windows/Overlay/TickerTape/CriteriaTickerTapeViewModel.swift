//
//  CriteriaTickerTapeViewModel.swift
//  SwiftAA
//
//  Created by Kihron on 2/27/24.
//

import SwiftUI

class CriteriaTickerTapeViewModel: ObservableObject {
    @ObservedObject private var dataManager = DataManager.shared
    @ObservedObject private var overlayManager = OverlayManager.shared
    
    @Published var containerLayer = CALayer()
    
    private var animationDuration: CFTimeInterval = 10
    private var previousCriteria: [Criterion] = []
    private var debounceWorkItem: DispatchWorkItem?
    
    init() {
        
    }

    func setupLayers(width: CGFloat) {
        containerLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let criteria = dataManager.incompleteCriteria.isEmpty && dataManager.completedCriteria.isEmpty ? dataManager.allCriteria : dataManager.incompleteCriteria
        guard !criteria.isEmpty else { return }
        
        let itemWidth: CGFloat = 24
        let padding: CGFloat = 10
        let totalItemWidth = itemWidth + padding
        let visibleItemCount = Int(ceil(width / totalItemWidth))
        let totalItemCount = max(visibleItemCount, criteria.count) * 2 // Ensure enough items for continuous scrolling
        
        for i in 0..<totalItemCount {
            let index = i % criteria.count
            let criterion = criteria[index]
            let layer = CriterionLayer(criterion: criterion)
            layer.frame = CGRect(x: CGFloat(i) * totalItemWidth, y: 0, width: itemWidth, height: itemWidth)
            containerLayer.addSublayer(layer)
        }
        
        animationDuration = CFTimeInterval((totalItemWidth * CGFloat(criteria.count)) / overlayManager.tickerTapeSpeed)
    }
    
    func startAnimation(width: CGFloat) {
        let criteria = dataManager.incompleteCriteria.isEmpty ? dataManager.allCriteria : dataManager.incompleteCriteria
        guard !criteria.isEmpty else { return }
        
        let padding: CGFloat = 10
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        let totalItemWidth = 24 + padding
        let distance = -totalItemWidth * CGFloat(criteria.count) // Distance for one set of items
        
        animation.values = overlayManager.invertScrollDirection ? [distance, 0] : [0, distance]
        animation.keyTimes = [0, 1]
        animation.duration = animationDuration
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        containerLayer.add(animation, forKey: "tickerAnimation")
    }
    
    func resetLayers(width: CGFloat, override: Bool = true) {
        let currentCriteria = dataManager.incompleteCriteria.isEmpty ? dataManager.allCriteria : dataManager.incompleteCriteria
        if currentCriteria != previousCriteria || override {
            containerLayer.removeAllAnimations()
            setupLayers(width: width)
            startAnimation(width: width)
        }
        previousCriteria = currentCriteria
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
