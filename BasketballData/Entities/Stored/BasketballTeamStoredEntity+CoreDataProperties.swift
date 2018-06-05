//
//  BasketballTeamStoredEntity+CoreDataProperties.swift
//  BasketballData
//
//  Created by Miguel Angel Adan Roman on 5/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//
//

import Foundation
import CoreData


extension BasketballTeamStoredEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BasketballTeamStoredEntity> {
        return NSFetchRequest<BasketballTeamStoredEntity>(entityName: "BasketballTeamStoredEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var player: BasketballPlayerStoredEntity?

}
