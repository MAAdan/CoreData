//
//  FetchCoreDataPlayers.swift
//  FantasyBasketballHelper
//
//  Created by Miguel Angel Adan Roman on 3/4/18.
//  Copyright © 2018 FantasyHelpers. All rights reserved.
//

import Foundation
import CoreData

class PersistCoreDataPlayers: PlayersPersitantStorage, ManagedContextEntity {
    
    var managedObjectContext: NSManagedObjectContext?
    
    func setManagedObjectContext(_ context: NSManagedObjectContext?) {
        managedObjectContext = context
    }
    
    func save(players: [BasketballPlayer], success: SavePlayersPersitantStorageSuccess, error: PlayersPersitantStorageError) {
        
        guard let managedObjectContext = managedObjectContext else {
            let userInfo: [String : Any] = Dictionary<String, Any>.createErrorUserInfoData(message: "Persistant storage save error", value: "Managed context error", comment: "Imposible to save data to a nil value")
            error(NSError(domain: "FetchCoreDataPlayers.app.com", code: 500, userInfo: userInfo))
            
            return
        }
        
        let pled = NSEntityDescription.entity(forEntityName: "BasketballPlayerStoredEntity", in: managedObjectContext)
        let ted = NSEntityDescription.entity(forEntityName: "BasketballTeamStoredEntity", in: managedObjectContext)
        let ped = NSEntityDescription.entity(forEntityName: "BasketballPositionStoredEntity", in: managedObjectContext)
        let sed = NSEntityDescription.entity(forEntityName: "BasketballStatsStoredEntity", in: managedObjectContext)
        
        guard let playerEntityDescription = pled, let teamEntityDescription = ted, let positionEntityDescription = ped, let statsEntityDescription = sed else {
            
            let userInfo = Dictionary<String, Any>.createErrorUserInfoData(message: "Persistant storage save error", value: "Managed context error", comment: "Entity description is nil")
            error(NSError(domain: "FetchCoreDataPlayers.app.com", code: 501, userInfo: userInfo))
            
            return
        }
        
        var storedPlayers = [BasketballPlayerStoredEntity]()
        
        for player in players {
            
            let storedTeam = BasketballTeamStoredEntity(entity: teamEntityDescription, insertInto: managedObjectContext)
            storedTeam.id = player.team.id
            storedTeam.name = player.team.name
            
            let storedPlayer = BasketballPlayerStoredEntity(entity: playerEntityDescription, insertInto: managedObjectContext)
            storedPlayer.id = player.id
            storedPlayer.name = player.name
            storedPlayer.team = storedTeam
            storedPlayer.differential = player.differential
            
            let storedPositions = player.positions.map({ (p) -> BasketballPositionStoredEntity in
                let storedPosition = BasketballPositionStoredEntity(entity: positionEntityDescription, insertInto: managedObjectContext)
                storedPosition.position = p.description
                
                return storedPosition
            })
            
            if let playerStats = player.stats {
                let storedStats = playerStats.map({ (s) -> BasketballStatsStoredEntity in
                    let storedStats = BasketballStatsStoredEntity(entity: statsEntityDescription, insertInto: managedObjectContext)
                    storedStats.name = s.name
                    storedStats.value = s.value
                    
                    return storedStats
                })
                
                storedPlayer.stats = NSSet(array: storedStats)
            }
            
            storedPlayer.positions = NSSet(array: storedPositions)
            storedPlayers.append(storedPlayer)
        }
        
        do {
            try managedObjectContext.save()
            success()
        } catch let saveError {
            managedObjectContext.reset()
            error(saveError)
        }
    }
    
    func fetch(success: @escaping FetchPlayersPersitantStorageSuccess, error: @escaping PlayersPersitantStorageError) {
        
        if let managedObjectContext = managedObjectContext {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BasketballPlayerStoredEntity")
            //let sortDescriptor = NSSortDescriptor(key: "lastModified", ascending: false)
            //fetchRequest.sortDescriptors = [sortDescriptor]
            
            let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest, completionBlock: { (result: NSAsynchronousFetchResult) in
                
                if let storedPlayers = result.finalResult as? [BasketballPlayerStoredEntity], storedPlayers.count > 0 {
                    let players = self.mapStoredEntitiesIntoPlayers(storedPlayers)
                    success(players)
                } else {
                    error(NSError(domain: "FetchCoreDataPlayers.app.com", code: 400, userInfo: nil))
                }
            })
            
            do {
                try managedObjectContext.execute(asyncFetchRequest)
            } catch let err {
                error(err)
            }
        } else {
            error(NSError(domain: "FetchCoreDataPlayers.app.com", code: 500, userInfo: Dictionary<String, Any>.createErrorUserInfoData(
                message: "Persistant storage fetch error",
                value: "Managed context error",
                comment: "Imposible to fetch data from a nil value"
            )))
        }
    }
    
    
    func mapStoredEntitiesIntoPlayers(_ storedEntities: [BasketballPlayerStoredEntity]) -> [BasketballPlayer] {
        var players = [BasketballPlayer]()
        for storedPlayer in storedEntities {
            if let id = storedPlayer.id,
                let name = storedPlayer.name,
                let teamId = storedPlayer.team?.id,
                let teamName = storedPlayer.team?.name {
                let basketballTeam = BasketballTeam(id: teamId, name: teamName)
                
                let positionsString: [BasketballPosition]
                if let storedPositionsArray = storedPlayer.positions?.allObjects as? [BasketballPositionStoredEntity] {
                    positionsString = storedPositionsArray.map({ (storedPositionEntity) -> BasketballPosition in
                        if let position = storedPositionEntity.position {
                            return position.basketballPositionFromString()
                        }
                        
                        return BasketballPosition.c
                    })
                } else {
                    positionsString = [BasketballPosition]()
                }
                
                let basketballPlayer = BasketballPlayer(id: id, name: name, team: basketballTeam, positions: positionsString, differential: storedPlayer.differential)
                
                if let stats = storedPlayer.stats, let storedStatsArray = stats.allObjects as? [BasketballStatsStoredEntity] {
                    
                    let playerStatsArray = storedStatsArray.map({ (statStoredEntity) -> BasketballStats in
                        let stat = BasketballStats(name: statStoredEntity.name ?? "", value: statStoredEntity.value)
                        return stat
                    })
                    
                    basketballPlayer.stats = playerStatsArray
                }
                
                players.append(basketballPlayer)
            }
        }
        
        return players
    }
}
