//
//  AuthViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 20/02/2022.
//

import Foundation
import UIKit

enum AuthScreenTab{
    case login
    case signUp
}

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
    
    var currentTab : AuthScreenTab = .login
    
    let authModel: AuthModel = AuthModelImpl.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputGroupName.isHidden = true
        inputGroupPhone.isHidden = true
        setTextFieldBorder()
        decorateFacebookButton()
        setUpControlTab()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
        buttonGoogleLogin.onClick(target: self, action: #selector(onClickGoogleLogin))
    }
    
    private func setUpControlTab(){
        signUpTab.onClick(target: self, action: #selector(onClickSignUp))
        loginTab.onClick(target: self, action: #selector(onClickLogin))
    }
    
    @objc func onClickSignUp() {
        debugPrint("Click SignUp")
        if currentTab == .login {
            currentTab = .signUp
            changeTab(isLogin: false)
        }
    }
    
    @objc func onClickLogin(){
        debugPrint("Click Login")
        if currentTab == .signUp {
            currentTab = .login
            changeTab(isLogin: true)
        }
    }
    
    let googleAuth = GoogleAuth()
    @objc func onClickGoogleLogin(){
        debugPrint("Click Google Login")
//        self.mView as? UIViewController
        googleAuth.start(view: self as UIViewController, success: {[weak self] (data) in
            switch self?.currentTab {
            case .login:
                self?.loginWithGoogle(id: data.id)
            case .signUp:
                self?.signUpWithGoogle(name: data.giveName, email: data.email, phone: "", password: "", googleId: data.id)
            case .none:
                debugPrint("Error")
            }
        }) { (err) in
            self.showMessageAlert(err)
            debugPrint(err)
            
        }
    }
    
    private func signUpWithGoogle(name: String, email: String, phone: String, password: String, googleId: String){
        authModel.signUpWithGoogle(name: name, email: email, phone: phone, password: password, googleToken: googleId) { [weak self] result in
            switch result {
            case .success(_):
                self?.navigateToHomeController(isReplace: true)
            case .failure(let error):
                self?.showMessageAlert(error)
            }
        }
    }
    
    private func loginWithGoogle(id: String){
        authModel.loginWithGoogle(googleToken: id) {[weak self] result in
            switch result {
            case .success(_):
                self?.navigateToHomeController(isReplace: true)
            case .failure(let error):
                self?.showMessageAlert(error)
            }
        }
    }
    
    private func changeTab(isLogin: Bool){
        inputGroupPhone.isHidden = isLogin
        inputGroupName.isHidden = isLogin
        textfieldEmail.text = ""
        textfieldPhone.text = ""
        textfieldName.text = ""
        textfieldPassword.text = ""
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
        showLoadingAlert()
        switch currentTab {
        case .login:
            authModel.loginWithEmail(email: textfieldEmail.text ?? "", password: textfieldPassword.text ?? ""){ result in
                switch result {
                case .success(_):
                    self.presentedViewController?.dismiss(animated: false){
                        self.navigateToHomeController(isReplace: true)
                    }
                case .failure(let error):
                    self.presentedViewController?.dismiss(animated: false){
                        self.showMessageAlert(error)
                        debugPrint(error)
                    }
                }
            }
            break
        case .signUp:
            authModel.signUpWithEmail(name: textfieldName.text ?? "", email: textfieldEmail.text ?? "", phone: textfieldPhone.text ?? "", password: textfieldPassword.text ?? ""){ result in
                switch result {
                case .success(_):
                    self.dismiss(animated: false){
                        self.navigateToHomeController(isReplace: true)
                    }
                case .failure(let error):
                    self.dismiss(animated: false)
                    self.showMessageAlert(error)
                    debugPrint(error)
                }
            }
            break
        }
    }
}
