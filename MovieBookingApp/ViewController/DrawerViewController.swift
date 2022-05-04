//
//  DrawerViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 28/04/2022.
//

import Foundation
import UIKit

class DrawerViewController: UIViewController {
    @IBOutlet weak var logoutView: UIStackView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    let userModel: UserModel = UserModelImpl.shared
    let authModel: AuthModel = AuthModelImpl.shared
    
    var user: User? {
        didSet {
            lblName.text = user?.name ?? ""
            imgProfile.sd_setImage(with: URL(string: "\(baseURL)/\(user?.profileImage ?? "")"))
            lblEmail.text = user?.email ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = userModel.user
        logoutView.onClick(target: self, action: #selector(logout))
    }
    
    @objc func logout(){
        self.showLoadingAlert()
        self.authModel.logout{[weak self] result in
            switch result {
            case .success(_):
                // Close dialog
                self?.dismiss(animated: true) {
                    guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: GetStartedViewController.identifier) as? GetStartedViewController else {return}
//                    self?.view.window?.rootViewController = UINavigationController(rootViewController: vc)
                    if let root = self?.view.window?.rootViewController as? UINavigationController {
                        // Close drawer
                        self?.dismiss(animated: false){
                            root.setViewControllers([vc], animated: false)
                        }
                    }
                    
                }
            case .failure(let error):
                self?.showMessageAlert(error)
            }
        }
    }
}
