//
//  DataManager.swift
//  SwiftAA
//
//  Created by Kihron on 7/19/22.
//

import SwiftUI
import SWXMLHash

class DataManager: ObservableObject {
    private var trackerManager = TrackerManager.shared
    
    private var map = [String:[Advancement]]() {
        didSet {
            allAdvancements = map.values.flatMap({ $0 })
            allCriteria = allAdvancements.filter({ !$0.criteria.isEmpty }).flatMap({ $0.criteria })
            goalAdvancements = allAdvancements.lazy.filter({ !$0.criteria.isEmpty }).sorted(by: { $0.id < $1.id })
        }
    }
    
    var lastModified: Date = Date.now
    
    var allAdvancements: [Advancement] = []
    var allCriteria: [Criterion] = []
    var minimalisticAdvancements: [Advancement] = []
    
    @Published var completedAdvancements: [Advancement] = []
    @Published var incompleteAdvancements: [Advancement] = []
    @Published var incompleteCriteria: [Criterion] = []
    @Published var completedCriteria: [Criterion] = []
    @Published var goalAdvancements: [Advancement] = []
    
    var statusIndicators: [Indicator] = Constants.statusIndicators
    var statisticIndicators: [Indicator] = Constants.statisticIndicators
    
    var completedAllAdvancements: Bool {
        return incompleteAdvancements.isEmpty && !completedAdvancements.isEmpty
    }
    
    static let shared = DataManager()
    
    init() {
        loadAllAdvancements()
    }
    
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
    }
    
    private func loadAllAdvancements() {
        let fileManager = FileManager.default
        let folderPath = "Advancements/\(trackerManager.gameVersion.label)"
        
        guard let categoriesPath = Bundle.main.path(forResource: folderPath, ofType: nil), let categories = try? fileManager.contentsOfDirectory(atPath: categoriesPath) else {
            print("Error loading category files...")
            return
        }
        
        for category in categories {
            let path = "\(folderPath)/\((category as NSString).deletingPathExtension)"
            if let url = Bundle.main.url(forResource: path, withExtension: "xml"), let contents = try? String(contentsOf: url) {
                var advancements = [Advancement]()
                let xml = XMLHash.parse(contents)
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
                    
                    advancements.append(current)
                }
                
                if map[path] == nil {
                    map[path] = advancements
                }
            }
        }
        
        loadMinimalisticAdvancements()
    }
    
    private func loadMinimalisticAdvancements() {
        let file = "Advancements/\(trackerManager.gameVersion.label)/minimal"
        let url = Bundle.main.url(forResource: file, withExtension: "json")
        var advancements = [Advancement]()
        
        guard let url, let sublayout: SubLayout = try? JSONDecoder().decode(SubLayout.self, from: Data(contentsOf: url)) else {
            print("Error decoding sublayout")
            return
        }
        
        advancements.reserveCapacity(sublayout.advancements.count)
        for adv in sublayout.advancements {
            if adv.id.contains("+") {
                let ids = adv.id.split(separator: "+", maxSplits: 2)
                guard let first = allAdvancements.first(where: { $0.id == "minecraft:\(ids[0])" })?.asAdvancement else { continue }
                guard let second = allAdvancements.first(where: { $0.id == "minecraft:\(ids[1])" })?.asAdvancement else { continue }
                let dual = Advancement.DualAdvancement(first: first, second: second, shortName: adv.name)
                uncounted.append(dual)
                advancements.append(dual)
            } else {
                if let advFromMap = allAdvancements.first(where: { $0.id == "minecraft:\(adv.id)" })?.asAdvancement {
                    advancements.append(advFromMap)
                }
            }
        }
        
        minimalisticAdvancements = advancements
    }
    
    func getCategoryAdvancements(category: String, start: String = "", end: String = "") -> Binding<[Indicator]> {
        let file = "Advancements/\(trackerManager.gameVersion.label)/\(category)"
        
        if let category = map[file] {
            var filteredCategory = category
            if (!start.isEmpty) {
                filteredCategory = Array(filteredCategory.drop(while: { $0.id != start }))
            }
            if (!end.isEmpty) {
                if let index = category.lastIndex(where: { $0.id == end }) {
                    filteredCategory = filteredCategory.dropLast(category.count - index - 1)
                }
            }
            return .constant(filteredCategory)
        } else {
            return .constant([])
        }
    }
    
    func getGoalAdvancement(id: String) -> Binding<Advancement> {
        return .constant(goalAdvancements.first(where: { $0.id == id }) ?? Advancement.defaultValue)
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
        uncounted.removeAll()
        removeOldVersionFiles()
        loadAllAdvancements()
    }

    private func removeOldVersionFiles() {
        for key in map.keys {
            if (key != trackerManager.gameVersion.label) {
                map.removeValue(forKey: key)
            }
        }
        updateAdvancementFields()
        lastModified = Date.now
    }
}
