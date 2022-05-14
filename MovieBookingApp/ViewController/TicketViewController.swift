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
    
    let movieModel: MovieModel = MovieModelImpl.shared
    let cinemaModel: CinemaModel = CinemaModelImpl.shared
    
    var movieTicket: MovieTicket?
    
    var movie: Movie? {
        didSet {
            lblMovieName.text = movie?.originalTitle ?? ""
            if let path = movie?.posterPath {
                imageMovie.sd_setImage(with: URL(string: "\(w200ImageUrl)\(path)"))
            }
            
        }
    }
    
    var cinema: Cinema? {
        didSet {
            lblTheater.text = cinema?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateTicket()
        decorateImageMovie()
        setMovieTicket()
    }
    
    private func setMovieTicket(){
        if let ticket = movieTicket {
            lblBookingNo.text = ticket.bookingNo
            
            let bookingDate = ticket.bookingDate?.toDate(format: "yyyy-MM-dd")
            lblDate.text = "\(ticket.timeslot?.startTime ?? "") - \(bookingDate?.toFormat(format: "dd MMM") ?? "")"
            lblRow.text = ticket.row
            lblSeat.text = ticket.seat
            if let path = ticket.qrCode {
                imgBarcode.sd_setImage(with: URL(string: "\(baseURL)\(path)"))
            }
            lblPrice.text = ticket.total
            
            if let movieId = ticket.movieID {
                fetchMovieById(movieId: movieId)
            }
            if let cinemaId = ticket.cinemaID {
                fetchCinemaById(cinemaId: cinemaId)
            }
        }
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
    
    private func fetchMovieById(movieId: Int){
        movieModel.getMovieById(id: movieId){[weak self] result in
            switch result {
            case .success(let movie):
                self?.movie = movie
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    private func fetchCinemaById(cinemaId: Int){
        cinemaModel.getCinemaById(cinemaId: cinemaId){[weak self] result in
            switch result {
            case .success(let cinema):
                self?.cinema = cinema
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
