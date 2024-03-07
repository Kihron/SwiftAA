//
//  TransferableIndicator.swift
//  SwiftAA
//
//  Created by Kihron on 10/28/23.
//

import SwiftUI

class TransferableIndicator: Codable {}

extension TransferableIndicator: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .item)
    }
}
