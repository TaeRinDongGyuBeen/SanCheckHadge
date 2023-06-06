//
//  Character+CoreDataProperties.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/06.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var clothes: [String]?
    @NSManaged public var emotion: String?

}

extension Character : Identifiable {

}
