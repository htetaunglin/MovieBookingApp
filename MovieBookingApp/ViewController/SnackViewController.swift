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
    
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var btnPay: UIButton!
    
    let snackModel: SnackModel = SnackModelImpl.shared
    let paymentMethodModel: PaymentMethodModel = PaymentMethodModelImpl.shared
    let userModel: UserModel = UserModelImpl.shared
    
    var snacks: [Snack] = [] {
        didSet {
            heightOfComboSetTableView.constant = CGFloat(snacks.count * 80)
            comboSetTableView.reloadData()
        }
    }
    
    var paymentMethods: [PaymentMethod] = [] {
        didSet {
            heightOfPaymentTableView.constant = CGFloat(paymentMethods.count * 60)
            paymentMethodTableView.reloadData()
        }
    }
    
    var totalAmount: Double = 0 {
        didSet {
            lblSubTotal.text = "Sub total: \(totalAmount)$"
            btnPay.setTitle("Pay $\((MovieTicketVo.movieSeat?.getTotalAmount() ?? 0) + totalAmount)", for: .normal)
        }
    }
    
    var selectedCombo: [Snack: Int] = [Snack: Int]() {
        didSet {
            totalAmount = selectedCombo.reduce(0.0){ previous, combo in
                return previous + ((combo.key.price ?? 0) * Double(combo.value))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerComboSetTableView()
        decorateTextField()
        registerPaymentMethodTableView()
        calHeightOfTableViews()
        // API
        fetchSnacks()
        fetchPaymentMethod()
        btnPay.setTitle("Pay $\((MovieTicketVo.movieSeat?.getTotalAmount() ?? 0))", for: .normal)
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
        heightOfComboSetTableView.constant = CGFloat(0)
        heightOfPaymentTableView.constant = CGFloat(0)
    }
    
    private func fetchSnacks(){
        snackModel.getSnacks {[weak self] result in
            switch result {
            case .success(let snacks):
                self?.snacks = snacks;
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    private func fetchPaymentMethod(){
        paymentMethodModel.getPaymentMethods {[weak self] result in
            switch result {
            case .success(let methods):
                self?.paymentMethods = methods;
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    @IBAction func onClickPay(_ sender: Any) {
        MovieTicketVo.snackVo = SnackVo(snacks: selectedCombo)
        navigateToPaymentViewController()
    }
    
    deinit {
        MovieTicketVo.snackVo = nil
    }
}


extension SnackViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == comboSetTableView {
            return snacks.count
        } else if tableView == paymentMethodTableView {
            return paymentMethods.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == comboSetTableView {
            return snacks.count
        } else if tableView == paymentMethodTableView {
            return paymentMethods.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == comboSetTableView {
            let cell = tableView.dequeueCell(identifier: ComboSetTableViewCell.identifier, indexPath: indexPath) as ComboSetTableViewCell
            cell.snack = snacks[indexPath.row]
            cell.comboSetDelegate = self
            return cell
        } else if tableView == paymentMethodTableView{
            let cell = tableView.dequeueCell(identifier: PaymentMethodTableViewCell.identifier, indexPath: indexPath) as PaymentMethodTableViewCell
            cell.paymentMethod = paymentMethods[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension SnackViewController: ComboSetDelegate {
    func add(snack: Snack, count: Int) {
        selectedCombo[snack] = count
    }
    
    func minus(snack: Snack, count: Int) {
        selectedCombo[snack] = count
    }
}
