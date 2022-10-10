//
//  Notes+CoreDataProperties.swift
//  
//
//  Created by User on 06/08/22.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var date: String?
    @NSManaged public var editTime: String?
    @NSManaged public var email: String?
    @NSManaged public var location: String?
    @NSManaged public var photo: Data?
    @NSManaged public var subtitle: String?
    @NSManaged public var theme: String?
    @NSManaged public var title: String?

}
