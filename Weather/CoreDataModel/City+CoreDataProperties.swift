//
//  City+CoreDataProperties.swift
//  
//
//  Created by Константин Лопаткин on 06.04.2021.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var comment: NSSet?
    public var commentArray: [Comment] {
        let set = comment as? Set<Comment> ?? []
        return set.sorted {
            $0.id < $1.id
        }
    }
}

// MARK: Generated accessors for comment
extension City {

    @objc(addCommentObject:)
    @NSManaged public func addToComment(_ value: Comment)

    @objc(removeCommentObject:)
    @NSManaged public func removeFromComment(_ value: Comment)

    @objc(addComment:)
    @NSManaged public func addToComment(_ values: NSSet)

    @objc(removeComment:)
    @NSManaged public func removeFromComment(_ values: NSSet)

}
