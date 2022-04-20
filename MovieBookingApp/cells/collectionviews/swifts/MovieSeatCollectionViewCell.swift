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
    
    func bindData(movieSeatVo: MovieSeatVo){
        lblMovieSeatTitle.text = movieSeatVo.title
        if movieSeatVo.isMovieSeatRowTitle() {
            //Title
            viewContainerMovieSeat.layer.cornerRadius = 0
            viewContainerMovieSeat.backgroundColor = UIColor.white
        } else if movieSeatVo.isMovieSeatTaken() {
            //Taken
            viewContainerMovieSeat.clipsToBounds = true
            viewContainerMovieSeat.layer.cornerRadius = 8
            viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            viewContainerMovieSeat.backgroundColor = UIColor.init(named: "movie_seat_taken_color") ?? UIColor.gray
        } else if movieSeatVo.isMovieSeatAvailable() {
            //Available
            viewContainerMovieSeat.clipsToBounds = true
            viewContainerMovieSeat.layer.cornerRadius = 8
            viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            viewContainerMovieSeat.backgroundColor = UIColor.init(named: "movie_seat_available_color") ?? UIColor.gray
        } else {
            viewContainerMovieSeat.layer.cornerRadius = 0
            viewContainerMovieSeat.backgroundColor = UIColor.white
        }
    }
}
