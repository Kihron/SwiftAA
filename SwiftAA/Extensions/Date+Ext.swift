//
//  Date+Ext.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 9/5/23.
//

import SwiftUI

extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}
