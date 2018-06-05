//
//  RequestLocalPlayers.swift
//  FantasyBasketballHelper
//
//  Created by Miguel Angel Adan Roman on 3/4/18.
//  Copyright © 2018 FantasyHelpers. All rights reserved.
//

import Foundation

class RequestLocalPlayers: PlayersRequestHandler {
    
    func request(success: PlayersRequestHandlerSuccess, error: PlayersRequestHandlerError) {
        
        if let path = Bundle.main.path(forResource: "players", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                do {
                    if let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? [[String: Any]] {
                        success(dictionary)
                    }
                } catch let catchedError {
                    error(catchedError)
                }
            } catch let catchedError {
                error(catchedError)
                print("parse error: \(catchedError.localizedDescription)")
            }
        } else {
            let userInfo: [String : Any] = [
                NSLocalizedDescriptionKey :  NSLocalizedString("Parse error", value: "Invalid filename/path.", comment: ""),
                NSLocalizedFailureReasonErrorKey : NSLocalizedString("Parse error", value: "Invalid filename/path.", comment: "")
            ]
            
            error(NSError(domain: "", code: 500, userInfo: userInfo))
        }
    }
}
