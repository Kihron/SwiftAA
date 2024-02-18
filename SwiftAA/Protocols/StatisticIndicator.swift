//
//  StatisticIndicator.swift
//  SwiftAA
//
//  Created by Kihron on 2/17/24.
//

import SwiftUI

protocol StatisticIndicator: Indicator {
    
}

extension StatisticIndicator {
    var frameStyle: String {
        return "statistic"
    }
    
    var tooltip: String {
        return ""
    }
}
