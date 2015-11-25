//
//  MovieCustomCell.swift
//  MovieApp
//
//  Created by Fernando Ferreira on 25/11/15.
//  Copyright © 2015 Fernando Ferreira. All rights reserved.
//

import UIKit
import PINRemoteImage

class MovieCustomCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.pin_cancelImageDownload()
        posterImageView.image = nil
    }
    
    func loadCellForObject(movie: Movie) {
        posterImageView.pin_setImageFromURL(movie.thumbnail)
        nameLabel.text = movie.name;
        self.backgroundColor = UIColor.whiteColor()
    }
}