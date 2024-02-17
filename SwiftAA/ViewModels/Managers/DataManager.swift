//
//  DataManager.swift
//  SwiftAA
//
//  Created by Kihron on 7/19/22.
//

import SwiftUI
import SWXMLHash

class DataManager: ObservableObject {
    @ObservedObject private var versionManager = TrackerManager.shared
    
    @Published var map = [String:[Advancement]]() {
        didSet {
            allAdvancements = map.values.flatMap({ $0 })
        }
    }
    
    @Published var allAdvancements: [Advancement] = []
    
    @Published var stats: [Indicator] = Constants.statusIndicators
    @Published var statsData: [String:[String:Int]] = [String:[String:Int]]()
    
    @Published var lastModified: Date = Date.now
    
    @Published var completedAllAdvancements: Bool = false
    @Published var playTime: Int = 0
    
    static let shared = DataManager()
    
    init() {
        
    }
    
    var minimalCache: [Indicator]? = nil
    
    var uncounted = [Advancement]()
    
    var completedAdvancements: [Advancement] {
        return allAdvancements.lazy.filter({ $0.completed }).sorted {
            ($0.timestamp ?? Date(timeIntervalSince1970: 0), $0.id) < ($1.timestamp ?? Date(timeIntervalSince1970: 0), $1.id)
        }
    }
    
    var incompleteAdvancements: [Advancement] {
        return allAdvancements.filter({ !$0.completed })
    }
    
    var incompleteCriteria: [Criterion] {
        return allAdvancements.lazy.filter({ !$0.completed && !$0.criteria.isEmpty }).flatMap({ $0.criteria }).filter({ !$0.completed })
    }
    
    var completedCriteria: [Criterion] {
        return allAdvancements.lazy.filter({ !$0.completed && !$0.criteria.isEmpty }).flatMap({ $0.criteria }).filter({ $0.completed }).sorted {
            ($0.timestamp ?? Date(timeIntervalSince1970: 0), $0.id) < ($1.timestamp ?? Date(timeIntervalSince1970: 0), $1.id)
        }
    }
    
    private var advancementsWithCriteria: [Advancement] {
        return allAdvancements.filter({ !$0.criteria.isEmpty })
    }
    
    let ambigiousCriteria = ["hoglin", "tuxedo", "cat"]
    
    func decode(file: String, start: String = "", end: String = "") -> Binding<[Indicator]> {
        let file = "Advancements/\(versionManager.gameVersion.label)/\(file)"
        
        if let cache = map[file] {
            var filteredCache = cache
            if (!start.isEmpty) {
                filteredCache = Array(filteredCache.drop(while: { $0.id != start }))
            }
            if (!end.isEmpty) {
                if let index = cache.lastIndex(where: { $0.id == end }) {
                    filteredCache = filteredCache.dropLast(cache.count - index - 1)
                }
            }
            return .constant(filteredCache)
        }
        
        var advancements = [Advancement]()
        var fullList = [Advancement]()
        
        guard let url = Bundle.main.url(forResource: file, withExtension: "xml"),
              let contents = try? String(contentsOf: url) else {
            print("Error loading file: \(file)")
            return .constant([])
        }
        
        let xml = XMLHash.parse(contents)
        var addItems = start.isEmpty
        for item in xml["group"]["advancement"].all {
            guard let element = item.element else { continue }
            
            let id = element.attribute(by: "id")!.text
            let key = element.attribute(by: "key")!.text
            let name = element.attribute(by: "name")!.text
            let shortName = element.attribute(by: "short_name")?.text
            let icon = element.attribute(by: "icon")?.text ?? getIconFromID(id: id, separator: "/")
            let frameStyle = element.attribute(by: "type")?.text ?? "normal"
            let tooltip = element.attribute(by: "tooltip")?.text ?? ""
            let prefix = element.attribute(by: "prefix")?.text ?? "minecraft:"
            
            let criteria = item["criteria"]["criterion"].all.compactMap { c -> Criterion? in
                guard let c = c.element else { return nil }
                
                let id = c.attribute(by: "id")!.text
                let key = c.attribute(by: "key")!.text
                let name = c.attribute(by: "name")?.text ?? getNameFromID(id: id, prefix: prefix)
                let icon = c.attribute(by: "icon")?.text ?? getIconFromID(id: id, separator: ":")
                
                if let recipe = c.attribute(by: "recipe")?.text {
                    return Criterion.DualCriterion(id: id, key: key, name: name, icon: icon, recipe: recipe)
                } else {
                    return Criterion(id: id, key: key, name: name, icon: icon)
                }
            }
            
            let current: Advancement
            if let complex = element.attribute(by: "complex")?.text, complex == "trim" {
                current = TrimAdvancement(id: id, key: key, name: name, shortName: shortName, icon: icon, frameStyle: frameStyle, criteria: criteria, completed: false)
            } else {
                current = Advancement(id: id, key: key, name: name, shortName: shortName, icon: icon, frameStyle: frameStyle, criteria: criteria, completed: false, tooltip: tooltip)
            }
            
            fullList.append(current)
            if (addItems || id == start) {
                advancements.append(current)
            }
            if (end == id) {
                addItems = false
            }
        }
        
        DispatchQueue.main.async {
            if self.map[file] == nil {
                self.map[file] = fullList
            }
        }
        
        return .constant(advancements)
    }
    
    private func getIconFromID(id: String, separator: Character) -> String {
        let idx = id.lastIndex(of: separator)
        if (idx == nil) {
            return id
        }
        return String(id[idx!...].dropFirst())
    }
    
    private func getNameFromID(id: String, prefix: String) -> String {
        id.dropFirst(prefix.count).replacingOccurrences(of: "_", with: " ").capitalized
    }
    
    func getAdvancementForCriteria(criterion: Criterion) -> Advancement? {
        advancementsWithCriteria.first(where: { $0.criteria.contains(criterion) })
    }
    
    func gameVersionChanged() {
        minimalCache = nil
        DispatchQueue.main.async {
            self.removeOldVersionFiles()
        }
    }
    
    private func removeOldVersionFiles() {
        for key in map.keys {
            if (!key.contains(versionManager.gameVersion.label)) {
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
    
    func getMinimalisticAdvancements() -> Binding<[Indicator]> {
        if let minimalCache, !minimalCache.isEmpty {
            return .constant(minimalCache)
        }

        let file = "Advancements/\(versionManager.gameVersion.label)/minimal"
        let url = Bundle.main.url(forResource: file, withExtension: "json")
        var advancements = [Advancement]()
        
        guard let sublayout: SubLayout = try? JSONDecoder().decode(SubLayout.self, from: Data(contentsOf: url!)) else {
            print("Error decoding sublayout")
            return .constant([])
        }
        
        var fulllist = [Indicator]()
        let loaded = allAdvancements
        for category in sublayout.categories {
            fulllist += decode(file: category).wrappedValue
        }

        advancements.reserveCapacity(sublayout.advancements.count)
        for adv in sublayout.advancements {
            if adv.id.contains("+") {
                let ids = adv.id.split(separator: "+", maxSplits: 2)
                guard let first = fulllist.first(where: { $0.id == "minecraft:\(ids[0])" })?.asAdvancement else { continue }
                guard let second = fulllist.first(where: { $0.id == "minecraft:\(ids[1])" })?.asAdvancement else { continue }
                let dual = Advancement.DualAdvancement(first: first, second: second, shortName: adv.name)
                uncounted.append(dual)
                advancements.append(dual)
            } else {
                if let advFromMap = fulllist.first(where: { $0.id == "minecraft:\(adv.id)" })?.asAdvancement {
                    advancements.append(advFromMap)
                }
            }
        }
        
        if !loaded.isEmpty {
            minimalCache = advancements
        }
        
        return .constant(advancements)
    }
}
