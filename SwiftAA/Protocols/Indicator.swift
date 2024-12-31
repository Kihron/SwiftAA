//
//  Indicator.swift
//  SwiftAA
//
//  Created by Kihron on 8/2/22.
//

import SwiftUI

protocol Indicator {
    var id: String { get set }
    var key: String { get set }
    var name: String { get set }
    var icon: String { get set }
    var frameStyle: String { get }
    var completed: Bool { get set }
    var tooltip: String { get }
    
    @MainActor func update(progress: ProgressManager)
}

extension Indicator {
    var asIndicator: Indicator {
        get {self as Indicator}
        set {self = newValue as! Self}
    }
    var asAdvancement: Advancement {
        get {self as! Advancement}
        set {self = newValue as! Self}
    }
}
