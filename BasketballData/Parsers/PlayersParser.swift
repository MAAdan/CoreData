//
//  PlayersParser.swift
//  FantasyBasketballHelper
//
//  Created by Miguel Angel Adan Roman on 2/4/18.
//  Copyright © 2018 FantasyHelpers. All rights reserved.
//

import Foundation

class PlayersParser: BasketballPlayersParser {
    
    func parse(playersDictionary: [[String : Any]]) -> [BasketballPlayer] {
        
        var players = [BasketballPlayer]()
        
        for singlePlayerDict in playersDictionary {
            let id = singlePlayerDict["id"] as? String ?? ""
            let name = singlePlayerDict["name"] as? String ?? ""
            let teamName: String
            let idTeam: String
            if let team = singlePlayerDict["team"] as? [String: String] {
                teamName = team["name"] ?? ""
                idTeam = team["id"] ?? ""
            } else {
                teamName = ""
                idTeam = ""
            }
            
            let positions = singlePlayerDict["positions"] as? [String] ?? []
            let basketballPositions = positions.map({ (p) -> BasketballPosition in
                return p.basketballPositionFromString()
            })
            
            let basketballTeam = BasketballTeam(id: idTeam, name: teamName)
            let differential = singlePlayerDict["differential"] as? Double ?? 0.000
            
            let player = BasketballPlayer(id: id, name: name, team: basketballTeam, positions: basketballPositions, differential: differential)
            
            if let s = singlePlayerDict["stats"] as? [[String: String]] {
                player.setStatsWithDictionary(stats: s)
            }
            
            players.append(player)
        }
        
        return players
    }
}
