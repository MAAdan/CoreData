//
//  PositionCollectionViewCell.swift
//  FBH
//
//  Created by Miguel Angel Adan Roman on 8/4/17.
//  Copyright © 2017 Avantiic. All rights reserved.
//

import UIKit

class PositionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var positionText: UILabel!
    @IBOutlet weak var positionBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        positionBackground.layer.borderWidth = 1.8
        positionBackground.layer.borderColor = UIColor.fromRgb(0xE0E4EB).cgColor
        positionBackground.layer.cornerRadius = 3.0
    }
    
    func setSelectedState(_ selected: Bool, color: UIColor) {
        
        if selected {
            positionBackground.backgroundColor = color
            positionText.textColor = .white
        } else {
            positionBackground.backgroundColor = .white
            positionText.textColor = color
        }
    }
}
