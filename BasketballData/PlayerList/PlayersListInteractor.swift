//
//  PlayerListInteractor.swift
//  BasketballData
//
//  Created by Miguel Angel Adan Roman on 5/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation
import CoreData

typealias BasketballPlayersInteractorErrorClosure = (_ error: Error) -> Void
typealias BasketballPlayersInteractorSuccessClosure = (_ players: [BasketballPlayer]) -> Void

class PlayersInteractor {
    
    var players = [BasketballPlayer]()
    var filteredPlayers = [BasketballPlayer]()
    var parser: BasketballPlayersParser
    var requestHandler: PlayersRequestHandler
    var persistantStorageHandler: PlayersPersitantStorage
    var activePositionFilters: [BasketballPosition: Bool] = [
        .pg: false,
        .sg: false,
        .sf: false,
        .pf: false,
        .c: false
    ]
    
    
    init(parser: BasketballPlayersParser,
         requestHandler: PlayersRequestHandler,
         persistantStorageHandler: PlayersPersitantStorage) {
        
        self.parser = parser
        self.requestHandler = requestHandler
        self.persistantStorageHandler = persistantStorageHandler
    }
    
    func getPlayers(success: @escaping BasketballPlayersInteractorSuccessClosure,
                    error: @escaping BasketballPlayersInteractorErrorClosure) {
        
        persistantStorageHandler.fetch(success: { [weak self] (players) in
            if let sortedPlayers = self?.sortPlayers(players) {
                self?.players = sortedPlayers
                self?.filteredPlayers = sortedPlayers
                success(sortedPlayers)
            } else {
                let userInfo = Dictionary<String, Any>.createErrorUserInfoData(message: "Unknown error", value: "Unknown error", comment: "Unknown error")
                
                error(NSError(domain: "ListPlayersInteractor.app.com", code: 500, userInfo: userInfo))
            }
        }) { (storageError) in
            self.requestHandler.request(success: { [weak self] (playersDictionary) in
                guard let strongSelf = self else {
                    return
                }
                
                let parsedPlayers = strongSelf.parser.parse(playersDictionary: playersDictionary)
                let sortedPlayers = strongSelf.sortPlayers(parsedPlayers)
                strongSelf.players = sortedPlayers
                strongSelf.filteredPlayers = sortedPlayers
                strongSelf.persistantStorageHandler.save(players: strongSelf.players, success: {
                    success(strongSelf.players)
                }, error: { (saveError) in
                    error(saveError)
                })
            }) { (requestError) in
                error(requestError)
            }
        }
    }
    
    func sortPlayers(_ players: [BasketballPlayer]) -> [BasketballPlayer] {
        
        let sortedPlayers = players.sorted { (p1, p2) -> Bool in
            return p1.differential > p2.differential
        }
        
        return sortedPlayers
    }
    
    func applyFilters(searchText: String, basketballPlayers: [BasketballPlayer]) -> [BasketballPlayer] {
        let playersTmp: [BasketballPlayer]
        
        if searchText.count == 0 {
            playersTmp = basketballPlayers
        } else {
            playersTmp = basketballPlayers.filter({ (player) -> Bool in
                let name = player.name.lowercased()
                let team = player.team.name.lowercased()
                return name.contains(searchText.lowercased()) || team.contains(searchText.lowercased())
            })
            
        }
        
        let filteredPlayers = playersTmp.filter({ (player) -> Bool in
            for (key, value) in activePositionFilters {
                if value {
                    if !player.positions.contains(key) {
                        return false
                    }
                }
            }
            return true
        })
        
        return filteredPlayers
        
    }
}
