//
//  UserThemes+CoreDataProperties.swift
//  SwiftAA
//
//  Created by Kihron on 9/6/23.
//
//

import Foundation
import CoreData


extension UserThemes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserThemes> {
        return NSFetchRequest<UserThemes>(entityName: "UserThemes")
    }

    @NSManaged public var backgroundColor: String?
    @NSManaged public var textColor: String?
    @NSManaged public var borderColor: String?
    @NSManaged public var name: String?
    @NSManaged public var id: UUID?

}

extension UserThemes : Identifiable {

}
