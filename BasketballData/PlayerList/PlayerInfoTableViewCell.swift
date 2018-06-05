//
//  JugadoresEstadisticasTableViewCell.swift
//  FBH
//
//  Created by Miguel Angel Adan Roman on 5/4/17.
//  Copyright © 2017 Avantiic. All rights reserved.
//

import UIKit

class PlayerInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var selectedMark: UIView!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var positions: UICollectionView!
    @IBOutlet weak var puntos: UILabel!
    @IBOutlet weak var nombreJugador: UILabel!
    @IBOutlet weak var nombreEquipo: UILabel!
    var player: BasketballPlayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        puntos.text = ""
        nombreJugador.text = ""
        nombreEquipo.text = ""
        positions.dataSource = self
        positions.register(UINib(nibName: PositionCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: PositionCollectionViewCell.className)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        puntos.text = ""
        nombreJugador.text = ""
        nombreEquipo.text = ""
        
        selectedState(false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func selectedState(_ selected: Bool) {
        if selected == true {
            contentView.backgroundColor = UIColor.fromRgb(0xE5F6F7)
            selectedMark.isHidden = false
            rank.textColor = UIColor.fromRgb(0x007eff)
            puntos.textColor = UIColor.fromRgb(0x007eff)
        } else {
            contentView.backgroundColor = .white
            selectedMark.isHidden = true
            rank.textColor = UIColor.fromRgb(0x202746)
            puntos.textColor = UIColor.fromRgb(0x202746)
        }
    }
    
    func configure(withPlayer player: BasketballPlayer, rank: Int) {
        self.rank.text = "\(rank)"
        self.player = player
        self.nombreJugador.text = player.name.uppercased()
        self.puntos.text = String(describing: player.differential)
        self.nombreEquipo.text = player.team.name.uppercased()
        self.positions.reloadData()
    }
}



extension PlayerInfoTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 22, height: 22)
    }
}

extension PlayerInfoTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return player?.positions.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PositionCollectionViewCell.className, for: indexPath) as! PositionCollectionViewCell
        
        if let player = player {
            let position = player.positions[indexPath.row]
            cell.positionText.text = position.description.uppercased()
            cell.positionText.textColor = position.colorForPosition()
            cell.positionBackground.backgroundColor = .white
        }
        
        return cell
    }
}
