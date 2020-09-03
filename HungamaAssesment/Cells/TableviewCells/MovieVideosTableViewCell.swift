//
//  MovieVideosTableViewCell.swift
//  HungamaAssesment
//
//  Created by Amey Rane on 03/09/20.
//  Copyright © 2020 Amey Rane. All rights reserved.
//

import UIKit

class MovieVideosTableViewCell: UITableViewCell {

    @IBOutlet weak var movieVideosCollectionView: UICollectionView!
    
    var data: MovieVideoResponse?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieVideosCollectionView.register(UINib.init(nibName: "SimilarMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SimilarMoviesCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MovieVideosTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMoviesCollectionViewCell", for: indexPath) as? SimilarMoviesCollectionViewCell
        
        let movieData = data?.movies?[indexPath.row]
        
        cell?.movieImageView.loadImage(movieData?.key ?? "", type: .youtube)
        cell?.playLogoImageView.isHidden = false
        cell?.movieNameLabel.text = movieData?.name ?? ""
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width / 3 , height: 180)
    }
}
