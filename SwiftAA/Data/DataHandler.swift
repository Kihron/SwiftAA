//
//  DataHandler.swift
//  SwiftAA
//
//  Created by Dominic Thompson on 7/19/22.
//

import SwiftUI
import SWXMLHash

class DataHandler: ObservableObject {
    func decode(file: String) -> [Advancement] {
        var advancements = [Advancement]()
        
        let url = Bundle.main.url(forResource: file, withExtension: "xml")
        let contents: String
        
        do {
            contents = try String(contentsOf: url!)
        } catch {
            print(error)
            contents = "ERROR"
        }
        
        let xml = XMLHash.parse(contents)
        for item in xml["group"]["advancement"].all {
            let id = item.element!.attribute(by: "id")!.text
            let name = item.element!.attribute(by: "name")!.text
            let icon = item.element!.attribute(by: "icon")?.text ?? String(id[id.lastIndex(of: "/")!...].dropFirst())
            let frameStyle = item.element!.attribute(by: "type")?.text ?? "normal"
            advancements.append(Advancement(id: id, name: name, icon: icon, frameStyle: frameStyle, completed: false))
        }
        
        return advancements
    }
}
