//
//  PayCardCarouselCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 27/02/2022.
//

import UIKit

class PayCardCarouselCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardNumber4: UILabel!
    @IBOutlet weak var cardNumber3: UILabel!
    @IBOutlet weak var cardNumber2: UILabel!
    @IBOutlet weak var cardNumber1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardNumber1.addCharacterSpacing(kernValue: 4)
        cardNumber2.addCharacterSpacing(kernValue: 4)
        cardNumber3.addCharacterSpacing(kernValue: 4)
        cardNumber4.addCharacterSpacing(kernValue: 4)

    }

}
