//
//  BasketballPlayer.swift
//  FBH
//
//  Created by Miguel Angel Adan Roman on 8/4/17.
//  Copyright © 2017 Avantiic. All rights reserved.
//

import Foundation
import UIKit

enum BasketballPosition: String {
    case pg
    case sg
    case sf
    case pf
    case c
    
    static var allPositions: [BasketballPosition] {
        return [pg, sg, sf, pf, c]
    }
    
    var description: String {
        switch self {
        case .pg:
            return "pg"
        case .sg:
            return "sg"
        case .sf:
            return "sf"
        case .pf:
            return "pf"
        case .c:
            return "c"
        }
    }
    
    func colorForPosition() -> UIColor {
        switch self {
        case .pg:
            return UIColor.pgPosition()
        case .sg:
            return UIColor.sgPosition()
        case .sf:
            return UIColor.sfPosition()
        case .pf:
            return UIColor.pfPosition()
        case .c:
            return UIColor.cPosition()
        }
    }
}

extension String {
    func basketballPositionFromString() -> BasketballPosition {
        switch self {
        case "pg":
            return .pg
        case "sg":
            return .sg
        case "sf":
            return .sf
        case "pf":
            return .pf
        default:
            return .c
        }
    }
}

class BasketballPlayer {
    var id: String
    var name: String
    var team: BasketballTeam
    var positions: [BasketballPosition]
    var stats: [BasketballStats]?
    var differential: Double
    
    init(id: String, name: String, team: BasketballTeam, positions: [BasketballPosition], differential: Double) {
        self.id = id
        self.name = name
        self.team = team
        self.positions = positions
        self.differential = differential
    }
    
    func setStatsWithDictionary(stats: [[String: Any]]) {
        self.stats = [BasketballStats]()
        for statDict in stats {
            if let statName = statDict["name"] as? String, let statValue = statDict["value"] as? Double {
                self.stats?.append(BasketballStats(name: statName, value: statValue))
            }
        }
    }
    
    func getStats(withName name: String) -> BasketballStats? {
        if let stats = stats {
            for stat in stats {
                if stat.name == name {
                    return stat
                }
            }
        }
        
        return nil
    }
}
