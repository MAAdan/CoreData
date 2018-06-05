//
//  ViewController.swift
//  BasketballData
//
//  Created by Miguel Angel Adan Roman on 5/6/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import UIKit
import CoreData

class PlayersListViewController: UIViewController, ManagedContextEntity {
    
    @IBOutlet weak var tableView: UITableView!
    
    var managedObjectContext: NSManagedObjectContext?
    var playersInteractor: PlayersInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: PlayerInfoTableViewCell.className, bundle: nil), forCellReuseIdentifier: PlayerInfoTableViewCell.className)
        
        let playersParser = PlayersParser()
        let playersRequestHandler = RequestLocalPlayers()
        let persistantStorageHandler = PersistCoreDataPlayers()
        persistantStorageHandler.setManagedObjectContext(managedObjectContext)
        
        playersInteractor = PlayersInteractor(parser: playersParser,
                                              requestHandler: playersRequestHandler,
                                              persistantStorageHandler: persistantStorageHandler)
        
        playersInteractor?.getPlayers(success: { [weak self] (players) in
            self?.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setManagedObjectContext(_ context: NSManagedObjectContext?) {
        managedObjectContext = context
    }
}

extension PlayersListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersInteractor?.filteredPlayers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerInfoTableViewCell.className, for: indexPath) as! PlayerInfoTableViewCell
        
        if let player = playersInteractor?.filteredPlayers[indexPath.row] {
            cell.configure(withPlayer: player, rank: indexPath.row)
        }
        
        return cell
    }
}
