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
    
    @Published private var map = [String:[Advancement]]() {
        didSet {
            allAdvancements = map.values.flatMap({ $0 })
            allCriteria = allAdvancements.filter({ !$0.criteria.isEmpty }).flatMap({ $0.criteria })
        }
    }
    
    @Published var lastModified: Date = Date.now
    
    @Published var allAdvancements: [Advancement] = []
    @Published var allCriteria: [Criterion] = []
    
    @Published var completedAdvancements: [Advancement] = []
    @Published var incompleteAdvancements: [Advancement] = []
    @Published var incompleteCriteria: [Criterion] = []
    @Published var completedCriteria: [Criterion] = []
    @Published var goalAdvancements: [Advancement] = []
    
    @Published var statusIndicators: [Indicator] = Constants.statusIndicators
    @Published var statisticIndicators: [Indicator] = Constants.statisticIndicators
    
    var completedAllAdvancements: Bool {
        return incompleteAdvancements.isEmpty && !completedAdvancements.isEmpty
    }
    
    static let shared = DataManager()
    
    init() {
        
    }
    
    var minimalCache: [Indicator]? = nil
    
    var uncounted: [Indicator] = []
    
    private let baseTimeInterval = Date(timeIntervalSince1970: 0)
    
    func updateAdvancementFields() {
        completedAdvancements = allAdvancements.filter({ $0.completed }).sorted {
            ($0.timestamp ?? baseTimeInterval, $0.id) < ($1.timestamp ?? baseTimeInterval, $1.id)
        }
        incompleteAdvancements = allAdvancements.filter({ !$0.completed })
        incompleteCriteria = allCriteria.filter({ !$0.completed })
        completedCriteria = allCriteria.filter({ $0.completed }).sorted {
            ($0.timestamp ?? baseTimeInterval, $0.id) < ($1.timestamp ?? baseTimeInterval, $1.id)
        }
        goalAdvancements = allAdvancements.lazy.filter({ !$0.criteria.isEmpty }).sorted(by: { $0.id < $1.id })
    }
    
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
            let key = generateAdvancementKey(id: id, element: element)
            let name = element.attribute(by: "name")!.text
            let shortName = generateShortKey(id: id, element: element)
            let icon = element.attribute(by: "icon")?.text ?? getIconFromID(id: id, separator: "/")
            let frameStyle = element.attribute(by: "type")?.text ?? "normal"
            let tooltip = element.attribute(by: "tooltip")?.text ?? ""
            let prefix = element.attribute(by: "prefix")?.text ?? "minecraft:"
            
            let goal = item["criteria"].element?.attribute(by: "goal")?.text
            let criteria = item["criteria"]["criterion"].all.compactMap { c -> Criterion? in
                guard let c = c.element, let goal else { return nil }
                
                let id = c.attribute(by: "id")!.text
                let key = generateCriterionKey(id: id, goal: goal, element: c, prefix: prefix)
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
            addItems = addItems || id == start
            if (addItems) {
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
    
    private func generateBaseKey(id: String) -> String {
        return "advancement." + id.replacingOccurrences(of: "minecraft:", with: "").replacingOccurrences(of: "/", with: ".")
    }
    
    private func generateAdvancementKey(id: String, element: SWXMLHash.XMLElement) -> String {
        let generatedKey = generateBaseKey(id: id)
        if let override = element.attribute(by: "version")?.text {
            return generatedKey + ".\(override)"
        } else {
            return generatedKey
        }
    }
    
    private func generateShortKey(id: String, element: SWXMLHash.XMLElement) -> String? {
        let shortKey = generateBaseKey(id: id) + ".short"
        return element.attribute(by: "short_name") != nil ? shortKey : nil
    }
    
    private func generateCriterionKey(id: String, goal: String, element: SWXMLHash.XMLElement, prefix: String) -> String {
        let generatedKey = "advancement.goal." + "\(goal.lowercased().replacingOccurrences(of: " ", with: "_"))." + id.replacingOccurrences(of: "minecraft:", with: "")
        if let override = element.attribute(by: "version")?.text {
            return generatedKey + ".\(override)"
        } else {
            return generatedKey
        }
    }
    
    private func getIconFromID(id: String, separator: Character) -> String {
        let idx = id.lastIndex(of: separator)
        if (idx == nil) {
            return id
        }
        return String(id[idx!...].dropFirst())
    }
    
    private func getNameFromID(id: String, prefix: String) -> String {
        if id.contains(prefix) {
            id.dropFirst(prefix.count).replacingOccurrences(of: "_", with: " ").capitalized
        } else {
            id.replacingOccurrences(of: "_", with: " ").capitalized
        }
    }
    
    func getAdvancementForCriteria(criterion: Criterion) -> Advancement? {
        goalAdvancements.first(where: { $0.criteria.contains(criterion) })
    }
    
    func gameVersionChanged() {
        minimalCache = nil
        uncounted.removeAll()
        DispatchQueue.main.async {
            self.removeOldVersionFiles()
        }
    }

    private func removeOldVersionFiles() {
        for key in map.keys {
            if (key != versionManager.gameVersion.label) {
                map.removeValue(forKey: key)
            }
        }
        updateAdvancementFields()
        lastModified = Date.now
    }
    
    func getMinimalisticAdvancements() -> Binding<[Indicator]> {
        if let minimalCache, !minimalCache.isEmpty {
            return .constant(minimalCache)
        }

        let file = "Advancements/\(versionManager.gameVersion.label)/minimal"
        let url = Bundle.main.url(forResource: file, withExtension: "json")
        var advancements = [Advancement]()
        
        guard let url, let sublayout: SubLayout = try? JSONDecoder().decode(SubLayout.self, from: Data(contentsOf: url)) else {
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
