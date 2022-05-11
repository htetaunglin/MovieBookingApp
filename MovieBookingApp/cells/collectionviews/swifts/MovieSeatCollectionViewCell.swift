//
//  MovieSeatCollectionViewCell.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 19/02/2022.
//

import UIKit

class MovieSeatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblMovieSeatTitle: UILabel!
    @IBOutlet weak var viewContainerMovieSeat: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindData(seat: Seat, isSelected: Bool){
        lblMovieSeatTitle.text = ""
        if seat.isMovieSeatRowTitle() {
            //Title
            lblMovieSeatTitle.text = seat.symbol
            viewContainerMovieSeat.layer.cornerRadius = 0
            viewContainerMovieSeat.backgroundColor = UIColor.white
            lblMovieSeatTitle.textColor = UIColor.black
            lblMovieSeatTitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        } else if seat.isMovieSeatTaken() {
            //Taken
            viewContainerMovieSeat.clipsToBounds = true
            viewContainerMovieSeat.layer.cornerRadius = 8
            viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            viewContainerMovieSeat.backgroundColor = UIColor.init(named: "movie_seat_taken_color") ?? UIColor.gray
        } else if seat.isMovieSeatAvailable() {
            //Available
            viewContainerMovieSeat.clipsToBounds = true
            viewContainerMovieSeat.layer.cornerRadius = 8
            viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            viewContainerMovieSeat.backgroundColor = UIColor.init(named: isSelected ? "primary_color":"movie_seat_available_color") ?? UIColor.gray
            if isSelected {
                lblMovieSeatTitle.text = seat.seatName.split(separator: "-").last?.description ?? ""
                lblMovieSeatTitle.textColor = UIColor.white
                lblMovieSeatTitle.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            }
        } else {
            viewContainerMovieSeat.layer.cornerRadius = 0
            viewContainerMovieSeat.backgroundColor = UIColor.white
        }
    }
    
    
}
