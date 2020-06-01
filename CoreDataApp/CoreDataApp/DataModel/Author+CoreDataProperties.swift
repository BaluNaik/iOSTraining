//
//  Author+CoreDataProperties.swift
//  CoreDataApp
//
//  Created by Balu Naik on 6/1/20.
//  Copyright © 2020 BaluTutorial. All rights reserved.
//
//

import Foundation
import CoreData


extension Author {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest<Author>(entityName: "Author")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var commit: Commit?

}
