//
//  Note+CoreDataProperties.swift
//  Journal X Simple
//
//  Created by ADM-12 on 10/02/20.
//  Copyright © 2020 Amogh Joshi. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var noteTitle: String?
    @NSManaged public var noteDescription: String?
    @NSManaged public var noteDate: Date?

}
