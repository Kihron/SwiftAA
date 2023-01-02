//
//  DataHandler.swift
//  SwiftAA
//
//  Created by Kihron on 7/19/22.
//

import SwiftUI
import SWXMLHash

class DataHandler: ObservableObject {
    @Published var map = [String:[Advancement]]()
    
    @Published var topStats: [Indicator] = [GodApple(), Trident(), Shells()]
    @Published var bottomStats: [Indicator] = [WitherSkulls(), AncientDebris()]
    @Published var stats: [Indicator] = [Indicator]()
    @Published var statsData: [String:[String:Int]] = [String:[String:Int]]()
    @Published var lastModified: Date = Date.now
    
    @Published var allAdvancements: Bool = false
    @Published var playTime: Int = 0
    
    var settings: AppSettings = .init()
    
    func decode(file: String, start: String = "", end: String = "") -> Binding<[Indicator]> {
        let file = "Advancements/\(settings.gameVersion)/\(file)"
        
        let cache = map[file]
        if (cache != nil) {
            var cache = cache!
            if (!start.isEmpty) {
                cache = Array(cache.drop(while: { $0.id != start }))
            }
            if (!end.isEmpty) {
                cache = cache.prefix(while: { $0.id != end })
            }
            return Binding.constant(cache)
        }
        
        var advancements = [Advancement]()
        var fullList = [Advancement]()
        
        let url = Bundle.main.url(forResource: file, withExtension: "xml")
        let contents: String
        
        do {
            contents = try String(contentsOf: url!)
        } catch {
            print(error)
            contents = "ERROR"
        }
        
        let xml = XMLHash.parse(contents)
        var addItems = start == ""
        for item in xml["group"]["advancement"].all {
            let id = item.element!.attribute(by: "id")!.text
            let key = item.element!.attribute(by: "key")!.text
            let name = item.element!.attribute(by: "name")!.text
            let icon = item.element!.attribute(by: "icon")?.text ?? getIconFromID(id: id, separator: "/")
            let frameStyle = item.element!.attribute(by: "type")?.text ?? "normal"
            let prefix = item.element!.attribute(by: "prefix")?.text ?? "minecraft:"
            let criteria: [Criterion] = (item.children.isEmpty) ? [] : item["criteria"]["criterion"].all.map({ c in
                let id = c.element!.attribute(by: "id")!.text
                let key = c.element!.attribute(by: "key")!.text
                let name = c.element!.attribute(by: "name")?.text ?? getNameFromID(id: id, prefix: prefix)
                let icon = c.element!.attribute(by: "icon")?.text ?? getIconFromID(id: id, separator: ":")
                return Criterion(id: id, key: key, name: name, icon: icon, completed: false)
            })
            let current = Advancement(id: id, key: key, name: name, icon: icon, frameStyle: frameStyle, criteria: criteria, completed: false)
            fullList.append(current)
            addItems = addItems || id == start
            if (addItems) {
                advancements.append(current)
            }
            if (end == id) {
                addItems = false
            }
        }
        
        DispatchQueue.main.async {
            self.map[file] = fullList
            self.stats = self.topStats + self.bottomStats
        }
        return Binding.constant(advancements)
    }
    
    func getIconFromID(id: String, separator: Character) -> String {
        let idx = id.lastIndex(of: separator)
        if (idx == nil) {
            return id
        }
        return String(id[idx!...].dropFirst())
    }
    
    func getNameFromID(id: String, prefix: String) -> String {
        id.dropFirst(prefix.count).replacingOccurrences(of: "_", with: " ").capitalized
    }
    
    func removeOldVersion(gameVersion: String) {
        for key in map.keys {
            if (!key.contains(gameVersion)) {
                map.removeValue(forKey: key)
            }
        }
        lastModified = Date.now
    }
    
    func ticksToIGT(ticks: Int) -> String {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.hour, .minute, .second]
        dateFormatter.unitsStyle = .positional
        dateFormatter.zeroFormattingBehavior = .pad
        return dateFormatter.string(from: Double(ticks / 20)) ?? "0:00:00"
    }
    
    //https://stackoverflow.com/questions/72443976/how-to-get-arguments-of-nsrunningapplication
    func processArguments(pid: pid_t) -> [String]? {
        
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
