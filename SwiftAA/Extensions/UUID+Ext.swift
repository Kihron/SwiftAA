//
//  UUID+Ext.swift
//  SwiftAA
//
//  Created by Kihron on 9/6/23.
//

import SwiftUI

extension UUID: RawRepresentable {
    public var rawValue: String {
        self.uuidString
    }

    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        self.init(uuidString: rawValue)
    }
}
