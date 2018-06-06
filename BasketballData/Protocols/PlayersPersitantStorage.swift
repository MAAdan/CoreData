//
//  PlayersPersitantStorage.swift
//  BasketballData
//
//  Created by Miguel Angel Adan Roman on 5/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation

protocol PlayersPersitantStorage {
    typealias SavePlayersPersitantStorageSuccess = () -> Void
    typealias FetchPlayersPersitantStorageSuccess = (_ players: [BasketballPlayer]) -> Void
    typealias PlayersPersitantStorageError = (_ error: Error) -> Void
    
    func fetch(success: @escaping FetchPlayersPersitantStorageSuccess, error: @escaping PlayersPersitantStorageError)
    func save(players: [BasketballPlayer], success: SavePlayersPersitantStorageSuccess, error: PlayersPersitantStorageError)
    func setDifferentialToZero(completion: (_ updated: Int) -> Void)
    func removePlayers(completion: (_ error: Error?) -> Void)
}
