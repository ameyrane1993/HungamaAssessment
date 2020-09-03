//
//  MovieListingTableViewCell.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 02/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import UIKit

protocol MovieListingTableViewDelegate: class {
    func movieBookButtonPressed(sender: UIButton)
}

class MovieListingTableViewCell: UITableViewCell {

    @IBOutlet weak var movieDetailContainerView: UIView!
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieRatingsLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    @IBOutlet weak var movieBookButton: UIButton!
    
    weak var delegate: MovieListingTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        movieDetailContainerView.layer.cornerRadius = 5.0
//        movieDetailContainerView.layer.masksToBounds = true
        movieDetailContainerView.setCornerRadiusWith(radius: 8)
        
        moviePosterImageView.layer.cornerRadius = 5.0
        moviePosterImageView.layer.masksToBounds = true
        
        movieBookButton.layer.cornerRadius = 4.0
        movieBookButton.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func movieBookButtonPressed(_ sender: UIButton) {
        delegate?.movieBookButtonPressed(sender: sender)
    }
    
}
