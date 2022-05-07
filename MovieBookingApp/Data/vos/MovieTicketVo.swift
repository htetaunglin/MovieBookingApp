//
//  MovieTicketVo.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 07/05/2022.
//

import Foundation

class MovieTicketVo {
    static var movie: Movie?
    static var movieTime: MovieTimeVo?
    static var movieSeat: MovieSeatVo?
    static var snackVo: SnackVo?
}

struct MovieTimeVo {
    var date: Date
    var cinema: Cinema
    var cinemaTimeSlot: CinemaTimeSlot
    var timeSlot: Timeslot
}

struct MovieSeatVo {
    var seat: [Seat]
    
    func getTotalAmount() -> Int {
        return seat.reduce(0) { previous, s in
           return previous + (s.price ?? 0)
       }
    }
    
    func getTotalCount() -> Int {
        return seat.count
    }
}

struct SnackVo {
    var snacks: [Snack: Int]
    
    func getTotalAmount() -> Int {
        return snacks.reduce(0){ previous, combo in
            return previous + ((combo.key.price ?? 0) * combo.value)
        }
    }
}
