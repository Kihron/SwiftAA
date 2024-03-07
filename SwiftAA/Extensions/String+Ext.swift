//
//  String+Ext.swift
//  SwiftAA
//
//  Created by Kihron on 8/9/22.
//

import SwiftUI

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localized(_ args: [CVarArg]) -> String {
        String(format: localized, arguments: args)
    }
    
    func localized(value: String) -> String {
        NSLocalizedString(self, value: value, comment: "\(self)_comment")
    }
}
