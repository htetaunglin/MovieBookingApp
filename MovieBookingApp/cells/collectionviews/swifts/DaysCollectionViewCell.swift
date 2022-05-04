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
    
    var isSelect: Bool = false {
        didSet {
            if isSelect {
                lblDay.textColor = UIColor.white
                lblDay.layer.opacity = 1
                lblDay.font = UIFont.systemFont(ofSize: 18)
                lblWeekDay.textColor = UIColor.white
                lblWeekDay.layer.opacity = 1
                lblWeekDay.font = UIFont.systemFont(ofSize: 18)
            } else {
                lblDay.textColor = UIColor.white
                lblDay.layer.opacity = 0.6
                lblDay.font = UIFont.systemFont(ofSize: 16)
                lblWeekDay.textColor = UIColor.white
                lblWeekDay.layer.opacity = 0.6
                lblWeekDay.font = UIFont.systemFont(ofSize: 16)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
