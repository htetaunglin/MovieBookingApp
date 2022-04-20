//
//  MovieSeatVo.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 19/02/2022.
//

import Foundation

struct MovieSeatVo{
    var title: String
    var type: String
    
    func isMovieSeatAvailable() -> Bool{
        return type == SEAT_TYPE_AVAILABLE
    }
    
    func isMovieSeatTaken() -> Bool{
        return type == SEAT_TYPE_TAKEN
    }
    
    func isMovieSeatRowTitle() -> Bool{
        return type == SEAT_TYPE_TEXT
    }
}
