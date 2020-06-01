//
//  Commit+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Balu Naik on 6/1/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//
//

import Foundation
import CoreData


extension Commit {

    // Must required to change method name because we have featchRequest in Data Model class also.
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Commit> {
        
        return NSFetchRequest<Commit>(entityName: "Commit")
    }

    @NSManaged public var date: Date?
    @NSManaged public var message: String?
    @NSManaged public var sha: String?
    @NSManaged public var url: String?
    @NSManaged public var author: Author?

}
