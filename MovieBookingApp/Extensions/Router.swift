//
//  Router.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 26/02/2022.
//

import Foundation
import UIKit

enum StoryBoardName: String {
    case Main = "Main"
    case LaunchScreen = "LaunchScreen"
}

extension UIStoryboard{
    static func mainStoryBoard() -> UIStoryboard{
        UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
    }
}

extension UIViewController{
    
    func navigateToAuthController(isReplace: Bool){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: AuthViewController.identifier) as? AuthViewController else {return}
        if isReplace {
            self.navigationController?.setViewControllers([vc], animated: true)
        } else {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func navigateToHomeController(isReplace: Bool){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: HomeViewController.identifier) as? HomeViewController else {return}
        if isReplace {
            self.navigationController?.setViewControllers([vc], animated: true)
        } else {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateMovieDetailViewController(movie: Movie?){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieDetailViewController.identifier) as? MovieDetailViewController else {return}
        vc.movieId = movie?.id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func navigateToMovieTimeViewController(){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieTimeViewController.identifier) as? MovieTimeViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieSeatViewController(){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieSeatViewController.identifier) as? MovieSeatViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToSnackViewController(){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: SnackViewController.identifier) as? SnackViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToPaymentViewController(){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: PaymentViewController.identifier) as? PaymentViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAddNewCardViewController(delegate: AddNewCardDelegate){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: AddNewCardViewController.identifier) as? AddNewCardViewController else {return}
        vc.delegate = delegate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToTicketViewController(ticket: MovieTicket){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: TicketViewController.identifier) as? TicketViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
