//
//  FoodViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 24/02/2022.
//

import Foundation
import UIKit

class SnackViewController: UIViewController{
    @IBOutlet weak var comboSetTableView: UITableView!
    @IBOutlet weak var textFieldPromoCode: UITextField!
    @IBOutlet weak var paymentMethodTableView: UITableView!

    @IBOutlet weak var heightOfComboSetTableView: NSLayoutConstraint!
    @IBOutlet weak var heightOfPaymentTableView: NSLayoutConstraint!
    
    final var count: Int = 6
    override func viewDidLoad() {
        super.viewDidLoad()
        registerComboSetTableView()
        decorateTextField()
        registerPaymentMethodTableView()
        calHeightOfTableViews()
    }
    
    private func registerComboSetTableView(){
        comboSetTableView.registerForCell(identifier: ComboSetTableViewCell.identifier)
        comboSetTableView.dataSource = self
    }
    
    
    private func registerPaymentMethodTableView(){
        paymentMethodTableView.registerForCell(identifier: PaymentMethodTableViewCell.identifier)
        paymentMethodTableView.dataSource = self
    }
    
    private func decorateTextField(){
        textFieldPromoCode.addMyTextFieldStyle(insertPadding: false)
    }
    
    private func calHeightOfTableViews(){
        heightOfComboSetTableView.constant = CGFloat(count * 80)
        heightOfPaymentTableView.constant = CGFloat(count * 60)
    }
    
    @IBAction func onClickPay(_ sender: Any) {
        navigateToPaymentViewController()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension SnackViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == comboSetTableView {
            let cell = tableView.dequeueCell(identifier: ComboSetTableViewCell.identifier, indexPath: indexPath)
            return cell
        } else if tableView == paymentMethodTableView{
            let cell = tableView.dequeueCell(identifier: PaymentMethodTableViewCell.identifier, indexPath: indexPath)
            return cell
        }
        return UITableViewCell()
    }
}
