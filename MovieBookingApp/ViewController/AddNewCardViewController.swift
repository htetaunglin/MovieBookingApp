//
//  PaymentFormViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 26/02/2022.
//

import Foundation
import UIKit

class AddNewCardViewController: UIViewController{
    
    @IBOutlet weak var textFieldCardNumber: UITextField!
    @IBOutlet weak var textFieldCardHolder: UITextField!
    @IBOutlet weak var textFieldExpireDate: UITextField!
    @IBOutlet weak var textFieldCVC: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateTextFields()
    }
    
    private func decorateTextFields(){
        textFieldCardNumber.addMyTextFieldStyle(insertPadding: true)
        textFieldCardHolder.addMyTextFieldStyle(insertPadding: true)
        textFieldExpireDate.addMyTextFieldStyle(insertPadding: true)
        textFieldCVC.addMyTextFieldStyle(insertPadding: true)
    }
    
    @IBAction func onClickAddNewTicket(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
