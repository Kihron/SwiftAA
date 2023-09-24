//
//  WorldNote+CoreDataProperties.swift
//  SwiftAA
//
//  Created by Kihron on 9/22/23.
//
//

import Foundation
import CoreData


extension WorldNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorldNote> {
        return NSFetchRequest<WorldNote>(entityName: "WorldNote")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var monument: String?
    @NSManaged public var outpost: String?
    @NSManaged public var stronghold: String?
    @NSManaged public var path: String?
    @NSManaged public var message: String?

}

extension WorldNote : Identifiable {

}
