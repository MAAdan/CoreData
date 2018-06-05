//
//  BasketballStatsStoredEntity+CoreDataProperties.swift
//  BasketballData
//
//  Created by Miguel Angel Adan Roman on 5/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//
//

import Foundation
import CoreData


extension BasketballStatsStoredEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BasketballStatsStoredEntity> {
        return NSFetchRequest<BasketballStatsStoredEntity>(entityName: "BasketballStatsStoredEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var value: Double
    @NSManaged public var player: BasketballPlayerStoredEntity?

}
