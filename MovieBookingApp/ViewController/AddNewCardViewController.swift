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
    
    let cardModel: PaymentCardModel = PaymentCardModelImpl.shared
    var delegate: AddNewCardDelegate?
    
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
        showLoadingAlert()
        let cardNo = textFieldCardNumber.text ?? ""
        let holder = textFieldCardHolder.text ?? ""
        let expire = textFieldExpireDate.text ?? ""
        let cvc = textFieldCVC.text ?? ""
        
        if cardNo.isEmpty {
            self.presentedViewController?.dismiss(animated: false) {
                self.showMessageAlert("Please fill card number")
            }
        } else if holder.isEmpty {
            self.presentedViewController?.dismiss(animated: false) {
                self.showMessageAlert("Please fill card holder")
            }
        } else if expire.isEmpty {
            self.presentedViewController?.dismiss(animated: false) {
                self.showMessageAlert("Please fill expire")
            }
        } else if cvc.isEmpty {
            self.presentedViewController?.dismiss(animated: false) {
                self.showMessageAlert("Please fill CVC")
            }
        } else {
            cardModel.createCard(cardNo: cardNo, holder: holder, expire: expire, cvc: cvc) { [weak self] result in
                switch result {
                case .success(let cards):
                    self?.presentedViewController?.dismiss(animated: false) {
                        self?.navigationController?.popViewController(animated: true)
                        self?.delegate?.onAddNewCard(cards: cards)
                    }
                case .failure(let error):
                    self?.presentedViewController?.dismiss(animated: false) {
                        self?.showMessageAlert(error)
                    }
                }
            }
        }
    }
}


protocol AddNewCardDelegate {
    func onAddNewCard(cards: [PaymentCard])
}
