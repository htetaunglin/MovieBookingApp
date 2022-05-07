//
//  PayCardCarouselCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 27/02/2022.
//

import UIKit

class PayCardCarouselCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCardType: UIImageView!
    @IBOutlet weak var lblCardHolder: UILabel!
    @IBOutlet weak var lblExpires: UILabel!
    
    @IBOutlet weak var cardNumber4: UILabel!
    @IBOutlet weak var cardNumber3: UILabel!
    @IBOutlet weak var cardNumber2: UILabel!
    @IBOutlet weak var cardNumber1: UILabel!
    
    var paymentCard: PaymentCard? {
        didSet {
            if let card = paymentCard {
                cardNumber4.text = card.cardNumber.suffix(4).description
                lblCardHolder.text = card.cardHolder
                lblExpires.text = card.expireDate
                if card.cardType == "JCB" {
                    imgCardType.image = UIImage(named: "jcb")
                } else {
                    imgCardType.image = UIImage(named: "visa")
                }
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardNumber1.addCharacterSpacing(kernValue: 4)
        cardNumber2.addCharacterSpacing(kernValue: 4)
        cardNumber3.addCharacterSpacing(kernValue: 4)
        cardNumber4.addCharacterSpacing(kernValue: 4)

    }

}
