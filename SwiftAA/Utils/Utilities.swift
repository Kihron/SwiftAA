//
//  Utilities.swift
//  SwiftAA
//
//  Created by Kihron on 10/28/23.
//

import SwiftUI

class Utilities {
    static private let indicators = DataManager.shared.stats
    
    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return dateFormatter
    }()
    
    static func convertToTimestamp(_ timestampString: String) -> Date? {
        return dateFormatter.date(from: timestampString)
    }
    
    static func getSpecificStats(types: [StatusType]) -> [Indicator] {
        if let array = indicators as? [StatusIndicator] {
            return array.filter { indicator in
                for type in types {
                    if indicator.type == type {
                        return true
                    }
                }
                return false
            }
        }
        return indicators
    }
    
    static func selectSavesFolder() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        if panel.runModal() == .OK {
            TrackerManager.shared.customSavesPath = panel.url?.path ?? ""
        }
        NSApp.keyWindow?.makeFirstResponder(nil)
    }
}