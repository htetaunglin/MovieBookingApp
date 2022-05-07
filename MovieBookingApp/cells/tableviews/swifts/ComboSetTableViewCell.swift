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
    
    @IBOutlet weak var lblComboSetName: UILabel!
    @IBOutlet weak var lblComboPrice: UILabel!
    @IBOutlet weak var lblComboDescription: UILabel!
    
    var snack: Snack? {
        didSet {
            if let sn = snack {
                lblComboSetName.text = sn.name
                lblComboPrice.text = sn.snackDescription
                lblComboPrice.text = "$\(sn.price ?? 0)"
            }
        }
    }
    var comboSetDelegate: ComboSetDelegate?
    
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
        let finalValue = value + 1
        lblCount.text = "\(finalValue)"
        comboSetDelegate?.add(snack: snack!, count: finalValue)
    }
    
    @IBAction func onDecrease(_ sender: Any) {
        let value: Int = Int(lblCount.text ?? "0") ?? 0
        if value > 0 {
            let finalValue = value - 1
            lblCount.text = "\(finalValue)"
            comboSetDelegate?.minus(snack: snack!, count: finalValue)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol ComboSetDelegate {
    func add(snack: Snack, count: Int)
    func minus(snack: Snack, count: Int)
}
