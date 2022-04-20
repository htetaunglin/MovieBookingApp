//
//  ComboSetTableViewCell.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 25/02/2022.
//

import UIKit

class ComboSetTableViewCell: UITableViewCell {

    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var changeButtonStackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        changeButtonStackView.setButtonBorder(color: UIColor.lightGray)
        btnMinus.setButtonBorder(color: UIColor.lightGray)
        btnAdd.setButtonBorder(color: UIColor.lightGray)
        btnMinus.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        btnAdd.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }

    @IBAction func onIncrease(_ sender: Any) {
        let value: Int = Int(lblCount.text ?? "0") ?? 0
        lblCount.text = ((value + 1) as NSNumber).stringValue
    }
    
    @IBAction func onDecrease(_ sender: Any) {
        let value: Int = Int(lblCount.text ?? "0") ?? 0
        if value > 0 {
            lblCount.text = ((value - 1) as NSNumber).stringValue
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
