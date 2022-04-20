//
//  NowShowingCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 20/02/2022.
//

import UIKit

class NowShowingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMoviePoster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        imageMoviePoster.clipsToBounds = false
//        imageMoviePoster.layer.shadowColor = UIColor.init(named: "primary_color")?.cgColor ?? UIColor.black.cgColor
//        imageMoviePoster.layer.shadowOffset = CGSize.zero
//        imageMoviePoster.layer.shadowRadius = 10
//        imageMoviePoster.layer.shadowOpacity = 1
//        imageMoviePoster.layer.shadowPath = UIBezierPath(rect: imageMoviePoster.bounds).cgPath
    }

}
