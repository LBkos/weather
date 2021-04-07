//
//  Comment+CoreDataProperties.swift
//  
//
//  Created by Константин Лопаткин on 06.04.2021.
//
//

import Foundation
import CoreData


extension Comment: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var city: City?

}
