//
//  BasketballPositionStoredEntity+CoreDataProperties.swift
//  BasketballData
//
//  Created by Miguel Angel Adan Roman on 5/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//
//

import Foundation
import CoreData


extension BasketballPositionStoredEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BasketballPositionStoredEntity> {
        return NSFetchRequest<BasketballPositionStoredEntity>(entityName: "BasketballPositionStoredEntity")
    }

    @NSManaged public var position: String?
    @NSManaged public var player: BasketballPlayerStoredEntity?

}
