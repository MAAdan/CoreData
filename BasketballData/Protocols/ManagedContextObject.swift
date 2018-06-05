//
//  ManagedContextObject.swift
//  BasketballData
//
//  Created by Miguel Angel Adan Roman on 5/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedContextEntity {
    var managedObjectContext: NSManagedObjectContext? { get set }
    func setManagedObjectContext(_ context: NSManagedObjectContext?)
}
