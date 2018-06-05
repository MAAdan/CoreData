//
//  BasketballPlayerStoredEntity+CoreDataProperties.swift
//  BasketballData
//
//  Created by Miguel Angel Adan Roman on 5/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//
//

import Foundation
import CoreData


extension BasketballPlayerStoredEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BasketballPlayerStoredEntity> {
        return NSFetchRequest<BasketballPlayerStoredEntity>(entityName: "BasketballPlayerStoredEntity")
    }

    @NSManaged public var differential: Double
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var positions: NSSet?
    @NSManaged public var stats: NSSet?
    @NSManaged public var team: BasketballTeamStoredEntity?

}

// MARK: Generated accessors for positions
extension BasketballPlayerStoredEntity {

    @objc(addPositionsObject:)
    @NSManaged public func addToPositions(_ value: BasketballPositionStoredEntity)

    @objc(removePositionsObject:)
    @NSManaged public func removeFromPositions(_ value: BasketballPositionStoredEntity)

    @objc(addPositions:)
    @NSManaged public func addToPositions(_ values: NSSet)

    @objc(removePositions:)
    @NSManaged public func removeFromPositions(_ values: NSSet)

}

// MARK: Generated accessors for stats
extension BasketballPlayerStoredEntity {

    @objc(addStatsObject:)
    @NSManaged public func addToStats(_ value: BasketballStatsStoredEntity)

    @objc(removeStatsObject:)
    @NSManaged public func removeFromStats(_ value: BasketballStatsStoredEntity)

    @objc(addStats:)
    @NSManaged public func addToStats(_ values: NSSet)

    @objc(removeStats:)
    @NSManaged public func removeFromStats(_ values: NSSet)

}
