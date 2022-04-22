//
//  AuthViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 20/02/2022.
//

import Foundation
import UIKit

class AuthViewController: UIViewController{
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var textfieldPhone: UITextField!
    
    @IBOutlet weak var inputGroupPhone: UIStackView!
    @IBOutlet weak var inputGroupName: UIStackView!
    
    @IBOutlet weak var buttonFacebookLogin: UIView!
    @IBOutlet weak var buttonGoogleLogin: UIView!
    
    @IBOutlet weak var signUpTab: UIStackView!
    @IBOutlet weak var loginTab: UIStackView!
    @IBOutlet weak var indicatorOfSignUp: UIView!
    @IBOutlet weak var indicatorOfLogin: UIView!
    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var lblLogin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputGroupName.isHidden = true
        inputGroupPhone.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setTextFieldBorder()
        decorateFacebookButton()
        setUpControlTab()
    }
    
    private func setTextFieldBorder(){
        textfieldEmail.addMyTextFieldStyle(insertPadding: true)
        textfieldPassword.addMyTextFieldStyle(insertPadding: true)
        textfieldName.addMyTextFieldStyle(insertPadding: true)
        textfieldPhone.addMyTextFieldStyle(insertPadding: true)
    }
    private func decorateFacebookButton(){
        buttonFacebookLogin.setButtonBorder(color: UIColor.init(named: "movie_seat_available_color") ?? UIColor.gray)
        buttonGoogleLogin.setButtonBorder(color: UIColor.init(named: "movie_seat_available_color") ?? UIColor.gray)
    }
    
    private func setUpControlTab(){
        signUpTab.onClick(target: self, action: #selector(onClickSignUp))
        loginTab.onClick(target: self, action: #selector(onClickLogin))
    }
    
    @objc func onClickSignUp() {
        debugPrint("Click SignUp")
        changeTab(isLogin: false)
    }
    
    @objc func onClickLogin(){
        debugPrint("Click Login")
        changeTab(isLogin: true)
    }
    
    private func changeTab(isLogin: Bool){
        inputGroupPhone.isHidden = isLogin
        inputGroupName.isHidden = isLogin
        if isLogin {
            indicatorOfLogin.backgroundColor = UIColor.init(named: "primary_color")
            lblLogin.textColor = UIColor.init(named: "primary_color")
            indicatorOfSignUp.backgroundColor = UIColor.clear
            lblSignUp.textColor = UIColor.black
        } else {
            indicatorOfLogin.backgroundColor = UIColor.clear
            lblLogin.textColor = UIColor.black
            indicatorOfSignUp.backgroundColor = UIColor.init(named: "primary_color")
            lblSignUp.textColor = UIColor.init(named: "primary_color")
        }
    }
    
    @IBAction func onClickConfirm(_ sender: Any) {
        navigateToHomeController()
    }
}
