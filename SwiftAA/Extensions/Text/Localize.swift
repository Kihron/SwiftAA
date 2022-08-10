//
//  Localize.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 8/9/22.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localized(_ args: [CVarArg]) -> String {
        return String(format: localized, arguments: args)
    }
}
