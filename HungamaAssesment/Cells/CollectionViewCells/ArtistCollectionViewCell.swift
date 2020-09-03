//
//  ArtistCollectionViewCell.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 02/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var artistImageView: UIImageView!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistCharacterNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        artistImageView.layer.cornerRadius = 5.0
        artistImageView.layer.masksToBounds = true
    }

}

