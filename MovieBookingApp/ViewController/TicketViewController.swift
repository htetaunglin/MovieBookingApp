//
//  TicketViewController.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 25/02/2022.
//

import Foundation
import UIKit

class TicketViewController: UIViewController{
    @IBOutlet weak var stackViewTicket: UIStackView!
    @IBOutlet weak var imageMovie: UIImageView!
    
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblBookingNo: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTheater: UILabel!
    @IBOutlet weak var lblRow: UILabel!
    @IBOutlet weak var lblSeat: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgBarcode: UIImageView!
    
    var movieTicket: MovieTicket? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateTicket()
        decorateImageMovie()
    }
    
    private func decorateTicket(){
        stackViewTicket.layer.masksToBounds = false
        stackViewTicket.layer.shadowOffset = CGSize(width: 1, height: 1)
        stackViewTicket.layer.shadowRadius = 3
        stackViewTicket.layer.shadowOpacity = 0.2
        
//        stackViewTicket.layer.masksToBounds = false
//        stackViewTicket.layer.shadowColor = UIColor.black.cgColor
//        stackViewTicket.layer.shadowOpacity = 0.5
//        stackViewTicket.layer.shadowOffset = CGSize(width: -1, height: 1)
//        stackViewTicket.layer.shadowRadius = 1
//
//        stackViewTicket.layer.shadowPath = UIBezierPath(rect: stackViewTicket.bounds).cgPath
//        stackViewTicket.layer.shouldRasterize = true
//        stackViewTicket.layer.rasterizationScale = UIScreen.main.scale//scale ? UIScreen.main.scale : 1
    }

    
    private func decorateImageMovie(){
        imageMovie.clipsToBounds = true
        imageMovie.layer.cornerRadius = 20
        imageMovie.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
