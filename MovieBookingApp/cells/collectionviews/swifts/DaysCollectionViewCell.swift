//
//  DaysCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 18/02/2022.
//

import UIKit

class DaysCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblWeekDay: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    
    var date: Date? {
        didSet {
            if let theDay = date {
                let dateFormatter = DateFormatter()

                dateFormatter.dateFormat = "dd"
                let dateString = dateFormatter.string(from: theDay)
                lblDay.text = dateString
                
                dateFormatter.dateFormat = "EE"
                let dayString = dateFormatter.string(from: theDay)
                lblWeekDay.text = dayString.uppercased()
                
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
