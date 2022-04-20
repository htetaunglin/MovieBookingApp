//
//  UITextFieldX.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 21/02/2022.
//

import Foundation
import UIKit

extension UITextField{
    func addMyTextFieldStyle(insertPadding: Bool){
        self.addBottomBorderWithColor(color: UIColor.init(named: "movie_seat_available_color") ?? UIColor.gray, width: 1)
        //Add Left Padding
        if insertPadding {
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
            self.leftView = leftPaddingView
            self.leftViewMode = .always
            self.rightView = leftPaddingView
            self.rightViewMode = .always
        }
        // Letter Spacing
        self.defaultTextAttributes.updateValue(0.7,
            forKey: NSAttributedString.Key.kern)
    }
}
