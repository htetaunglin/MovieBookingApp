//
//  PaymentMethodTableViewCell.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 25/02/2022.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblPaymentName: UILabel!
    @IBOutlet weak var lblPaymentDescription: UILabel!
    
    var paymentMethod: PaymentMethod? {
        didSet {
            lblPaymentName.text = paymentMethod?.name
            lblPaymentDescription.text = paymentMethod?.paymentMethodDescription
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
