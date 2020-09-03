//
//  MoviePosterTableViewCell.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 02/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import UIKit

class MoviePosterTableViewCell: UITableViewCell {

    @IBOutlet weak var posterContainerView: UIView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        posterContainerView.layer.cornerRadius = 5.0
        posterContainerView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
