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
    var frameStyle: String { get set }
    var completed: Bool { get set }
    
    func update(advancements: [String:JsonAdvancement], stats: [String:[String:Int]])
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
