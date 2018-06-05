//
//  PlayersRequestHandler.swift
//  BasketballData
//
//  Created by Miguel Angel Adan Roman on 5/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation

protocol PlayersRequestHandler {
    typealias PlayersRequestHandlerSuccess = (_ playersDictionary: [[String: Any]]) -> Void
    typealias PlayersRequestHandlerError = (_ error: Error) -> Void
    
    func request(success: PlayersRequestHandlerSuccess, error: PlayersRequestHandlerError)
}
