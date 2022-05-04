//
//  TimeCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 18/02/2022.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewTime.layer.borderColor =  UIColor.gray.cgColor
        viewTime.layer.borderWidth = 0.5
    }

}
