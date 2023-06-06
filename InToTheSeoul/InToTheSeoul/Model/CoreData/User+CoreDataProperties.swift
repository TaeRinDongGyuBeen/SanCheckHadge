//
//  User+CoreDataProperties.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/05.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var gender: String?
    @NSManaged public var age: Int16
    @NSManaged public var accumulateCoin: Int16
    @NSManaged public var accumulateDistance: Double
}

extension User : Identifiable {

}
