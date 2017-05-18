//
//  Event+CoreDataProperties.swift
//  
//
//  Created by Hernán Iruegas Villarreal on 27/04/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event");
    }

    @NSManaged public var content: String?
    @NSManaged public var published: String?
    @NSManaged public var timeStamp: NSDate?
    @NSManaged public var title: String?

}
