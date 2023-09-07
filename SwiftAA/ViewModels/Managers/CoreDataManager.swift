//
//  CoreDataManager.swift
//  SwiftAA
//
//  Created by Kihron on 9/6/23.
//

import SwiftUI
import CoreData

class CoreDataManager: NSObject, ObservableObject {
    let container: NSPersistentContainer = NSPersistentContainer(name: "Model")
    
    static let shared = CoreDataManager()
    
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
}
