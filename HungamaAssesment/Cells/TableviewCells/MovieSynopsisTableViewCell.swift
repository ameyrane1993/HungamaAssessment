//
//  MovieSynopsisTableViewCell.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 02/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import UIKit

class MovieSynopsisTableViewCell: UITableViewCell {
    
    var data : MovieSynopsisResponse?
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieLanguageLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
