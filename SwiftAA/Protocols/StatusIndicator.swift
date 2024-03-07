//
//  StatusIndicator.swift
//  SwiftAA
//
//  Created by Kihron on 10/27/23.
//

import SwiftUI

protocol StatusIndicator: Indicator {
    var type: StatusType { get }
}
