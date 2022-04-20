//
//  MovieTypeCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 21/02/2022.
//

import UIKit

class MovieTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewMovieType: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        decorateView()
    }
    
    private func decorateView(){
        viewMovieType.layer.borderColor = UIColor.systemGray5.cgColor
        viewMovieType.layer.borderWidth = 1
        viewMovieType.layer.cornerRadius = 20
    }

}
