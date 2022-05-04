//
//  NowShowingCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 20/02/2022.
//

import UIKit
import SDWebImage

class NowShowingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMoviePoster: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    var movie: Movie? {
        didSet {
            if let path = movie?.posterPath {
                let imagePath = "\(baseImageUrl)/\(path)"
                imageMoviePoster.sd_setImage(with: URL(string: imagePath))
            }
            lblName.text = movie?.originalTitle ?? ""
            lblSubTitle.text = movie?.genres?.joined(separator: "/")
        }
    }
   
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
