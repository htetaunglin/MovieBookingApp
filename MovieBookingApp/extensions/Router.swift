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
    
    func navigateMovieDetailViewController(){
        guard let vc = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieDetailViewController.identifier) as? MovieDetailViewController else {return}
        //Transition style
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
}
