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
    
    static var playTimeFormatter: DateComponentsFormatter {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.hour, .minute, .second]
        dateFormatter.unitsStyle = .positional
        dateFormatter.zeroFormattingBehavior = .pad
        return dateFormatter
    }
    
    static func convertToTimestamp(_ timestampString: String) -> Date? {
        return dateFormatter.date(from: timestampString)
    }
    
    static func getSpecificStats(types: [StatusType]) -> [Indicator] {
        if let array = indicators as? [StatusIndicator] {
            let filteredIndicators = array.filter { indicator in
                types.contains(indicator.type)
            }
            
            return filteredIndicators.sorted { (indicator1, indicator2) -> Bool in
                guard let index1 = types.firstIndex(of: indicator1.type), let index2 = types.firstIndex(of: indicator2.type) else {
                    return false
                }
                return index1 < index2
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
    
    static func readLastLine(ofFileAtPath path: String) -> String? {
        guard let fileHandle = FileHandle(forReadingAtPath: path) else {
            return nil
        }
        
        var offset: UInt64 = 0
        let fileSize = fileHandle.seekToEndOfFile()
        
        if fileSize == 0 { return nil }
        
        var data = Data()
        
        repeat {
            offset += 1
            fileHandle.seek(toFileOffset: fileSize - offset)
            let byteData = fileHandle.readData(ofLength: 1)
            if byteData[0] == 10 && offset != 1 { // 10 is ASCII for '\n'
                break
            }
            data.insert(contentsOf: byteData, at: 0)
        } while offset < fileSize
        
        fileHandle.closeFile()
        
        return String(data: data, encoding: .utf8)
    }
}
