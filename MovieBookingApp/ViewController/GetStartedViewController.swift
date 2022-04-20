//
//  GetStartedViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 19/02/2022.
//

import Foundation
import UIKit

class GetStartedViewController : UIViewController{
    @IBOutlet weak var btnGetStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateBtn()
    }
    
    func decorateBtn(){
        btnGetStart.layer.borderColor = UIColor.white.cgColor
        btnGetStart.layer.borderWidth = 1
    }
}
