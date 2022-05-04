//
//  UIViewControllerX.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 21/02/2022.
//

import Foundation
import UIKit


extension UIViewController{
    static var identifier: String{
        String (describing: self)
    }
    
//https://stackoverflow.com/questions/27960556/loading-an-overlay-when-running-long-tasks-in-ios
    func showLoadingAlert() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func showMessageAlert(_ message: String){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            self.dismiss(animated: true)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)

    }
}


