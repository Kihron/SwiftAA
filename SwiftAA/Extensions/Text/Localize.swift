//
//  Localize.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 8/9/22.
//

import Foundation

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
