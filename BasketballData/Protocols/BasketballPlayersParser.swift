//
//  BasketballPlayersParserProtocol.swift
//  BasketballData
//
//  Created by Miguel Angel Adan Roman on 5/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation

protocol BasketballPlayersParser {
    func parse(playersDictionary: [[String: Any]]) -> [BasketballPlayer]
}
