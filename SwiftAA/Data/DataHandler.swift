//
//  DataHandler.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI
import SWXMLHash

class DataHandler: ObservableObject {
    var map = [String:[Advancement]]()
    
    func decode(file: String, start: String = "", end: String = "") -> [Advancement] {
        var cache = map[file]
        if (cache != nil) {
            if (start != "") {
                while (cache![0].id != start) {
                    cache!.removeFirst()
                }
            }
            if (end != "") {
                while (cache![cache!.count - 1].id != end) {
                    cache!.removeLast()
                }
            }
            return cache!
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
            let name = item.element!.attribute(by: "name")!.text
            let icon = item.element!.attribute(by: "icon")?.text ?? getIconFromID(id: id, separator: "/")
            let frameStyle = item.element!.attribute(by: "type")?.text ?? "normal"
            let prefix = item.element!.attribute(by: "prefix")?.text ?? "minecraft:"
            let criteria: [Criterion] = (item.children.isEmpty) ? [] : item["criteria"]["criterion"].all.map({ c in
                let id = c.element!.attribute(by: "id")!.text
                let name = c.element!.attribute(by: "name")?.text ?? getNameFromID(id: id, prefix: prefix)
                let icon = c.element!.attribute(by: "icon")?.text ?? getIconFromID(id: id, separator: ":")
                return Criterion(id: id, name: name, icon: icon, completed: false)
            })
            let current = Advancement(id: id, name: name, icon: icon, frameStyle: frameStyle, criteria: criteria, completed: false)
            fullList.append(current)
            addItems = addItems || id == start
            if (addItems) {
                advancements.append(current)
            }
            if (end == id) {
                addItems = false
            }
        }
        
        map[file] = fullList
        return advancements
    }
    
    func getIconFromID(id: String, separator: Character) -> String {
        let idx = id.lastIndex(of: separator)
        if (idx == nil) {
            return id
        }
        return String(id[idx!...].dropFirst())
    }
    
    func getNameFromID(id: String, prefix: String) -> String {
        return id.dropFirst(prefix.count).replacingOccurrences(of: "_", with: " ").capitalized
    }
}
