//
//  CastCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 24/02/2022.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image_caster: UIImageView!
    
    var image: String? {
        didSet {
            if let path = image {
                if !path.isEmpty {
                    image_caster.sd_setImage(with: URL(string: "\(w200ImageUrl)\(path)"))
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
