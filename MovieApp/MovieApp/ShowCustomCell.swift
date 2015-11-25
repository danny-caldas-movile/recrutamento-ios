//
//  MovieCustomCell.swift
//  MovieApp
//
//  Created by Fernando Ferreira on 25/11/15.
//  Copyright © 2015 Fernando Ferreira. All rights reserved.
//

import UIKit
import PINRemoteImage

class ShowCustomCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.pin_cancelImageDownload()
    }
    
    func loadCellForObject(show: Show) {
        //posterImageView.pin_setImageFromURL(movie.thumbnail)
        posterImageView.tintColor = UIColor.lightGrayColor()
        posterImageView.pin_setImageFromURL(show.thumbnail, placeholderImage: UIImage(named: "tvShow"))
        titleLabel.text = show.title;
        self.backgroundColor = UIColor.whiteColor()
    }
}