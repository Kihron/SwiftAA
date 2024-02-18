//
//  Utilities.swift
//  SwiftAA
//
//  Created by Kihron on 10/28/23.
//

import SwiftUI

class Utilities {
    static private let indicators = DataManager.shared.statusIndicators
    
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
    
    //https://stackoverflow.com/questions/72443976/how-to-get-arguments-of-nsrunningapplication
    static func processArguments(pid: pid_t) -> [String]? {
        
        // Determine space for arguments:
        var name : [CInt] = [ CTL_KERN, KERN_PROCARGS2, pid ]
        var length: size_t = 0
        if sysctl(&name, CUnsignedInt(name.count), nil, &length, nil, 0) == -1 {
            return nil
        }
        
        // Get raw arguments:
        var buffer = [CChar](repeating: 0, count: length)
        if sysctl(&name, CUnsignedInt(name.count), &buffer, &length, nil, 0) == -1 {
            return nil
        }
        
        // There should be at least the space for the argument count:
        var argc : CInt = 0
        if length < MemoryLayout.size(ofValue: argc) {
            return nil
        }
        
        var argv: [String] = []
        
        buffer.withUnsafeBufferPointer { bp in
            
            // Get argc:
            memcpy(&argc, bp.baseAddress, MemoryLayout.size(ofValue: argc))
            var pos = MemoryLayout.size(ofValue: argc)
            
            // Skip the saved exec_path.
            while pos < bp.count && bp[pos] != 0 {
                pos += 1
            }
            if pos == bp.count {
                return
            }
            
            // Skip trailing '\0' characters.
            while pos < bp.count && bp[pos] == 0 {
                pos += 1
            }
            if pos == bp.count {
                return
            }
            
            // Iterate through the '\0'-terminated strings.
            for _ in 0..<argc {
                let start = bp.baseAddress! + pos
                while pos < bp.count && bp[pos] != 0 {
                    pos += 1
                }
                if pos == bp.count {
                    return
                }
                argv.append(String(cString: start))
                pos += 1
            }
        }
        
        return argv.count == argc ? argv : nil
    }
}
