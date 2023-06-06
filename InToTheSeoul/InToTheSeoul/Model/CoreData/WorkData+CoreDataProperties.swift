//
//  WorkData+CoreDataProperties.swift
//  InToTheSeoul
//
//  Created by 김동현 on 2023/06/06.
//
//

import Foundation
import CoreData


extension WorkData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkData> {
        return NSFetchRequest<WorkData>(entityName: "WorkData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var totalDistance: Int16
    @NSManaged public var gainCoin: Int16
    @NSManaged public var checkPoint: [String]?
    @NSManaged public var startPoint: String?
    @NSManaged public var moveRoute: [(Double)]?

}

extension WorkData : Identifiable {

}
