//
//  CriterionLayer.swift
//  SwiftAA
//
//  Created by Kihron on 3/4/24.
//

import SwiftUI

class CriterionLayer: CALayer {
    var criterion: Criterion
    
    init(criterion: Criterion) {
        self.criterion = criterion
        super.init()
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayer() {
        // Set the size of the criterion layer
        self.bounds = CGRect(x: 0, y: 0, width: 24, height: 24)
        
        var iconLayer: CALayer
        if Constants.animatedIcons.contains(criterion.icon) {
            iconLayer = AnimatedIconLayer(icon: criterion.icon)
            iconLayer.frame = CGRect(x: 0, y: 0, width: 24, height: 24).integral
            self.addSublayer(iconLayer)
        } else {
            iconLayer = CALayer()
            iconLayer.frame = CGRect(x: 0, y: 0, width: 24, height: 24).integral
            iconLayer.contents = NSImage(named: criterion.icon)?.cgImage(forProposedRect: nil, context: nil, hints: nil)
            iconLayer.contentsGravity = .resizeAspect
            iconLayer.magnificationFilter = .nearest
            self.addSublayer(iconLayer)
        }
        
        // Add overlay layer if necessary
        if OverlayManager.shared.clarifyAmbiguousCriteria && Constants.ambiguousCriteria.contains(criterion.icon),
           let adv = DataManager.shared.getAdvancementForCriteria(criterion: criterion) {
            let overlayLayer = CALayer()
            overlayLayer.contents = NSImage(named: adv.icon)?.cgImage(forProposedRect: nil, context: nil, hints: nil)
            overlayLayer.frame = CGRect(x: -5, y: 24 - 12, width: 16, height: 16)
            iconLayer.addSublayer(overlayLayer)
        }
    }
}
