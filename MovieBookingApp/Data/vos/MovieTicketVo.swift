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
    
    // TO USE Checkout
    static func totalCharges() -> Double {
        var amount: Double = 0
        amount = (movieSeat?.getTotalAmount() ?? 0) +  (snackVo?.getTotalAmount() ?? 0)
        return amount
    }
}

struct MovieTimeVo {
    var date: Date
    var cinema: Cinema
    var cinemaTimeSlot: CinemaTimeSlot
    var timeSlot: Timeslot
    
    // TO USE Checkout
    func getCinemaId() -> Int {
        return cinema.id ?? 0
    }
    
    // TO USE Checkout
    func getCinemaDayTimeSlotId() -> Int {
        return timeSlot.cinemaDayTimeslotID ?? 0
    }
    
    // TO USE Checkout
    func getBookingDate() -> String {
        return MovieTicketVo.movieTime?.date.toFormat(format: "yyyy-MM-dd") ?? ""
    }
}

struct MovieSeatVo {
    var seat: [Seat]
    
    func getTotalAmount() -> Double {
        return seat.reduce(0.0) { previous, s in
            return previous + (s.price ?? 0)
        }
    }
    
    func getTotalCount() -> Int {
        return seat.count
    }
    
    // TO USE Checkout
    func getRows() -> [String] {
        return Array(Set(seat.map{ $0.symbol ?? "" }))
    }
    
    // TO USE Checkout
    func getSeatNumbers() -> [String] {
        return seat.map{ $0.seatName ?? "" }
    }
}

struct SnackVo {
    var snacks: [Snack: Int]
    
    func getTotalAmount() -> Double {
        return snacks.reduce(0.0){ previous, combo in
            return previous + ((combo.key.price ?? 0) * Double(combo.value))
        }
    }
    
    // TO USE Checkout
    func getSnackDictionary() -> [[String: Int]]{
        return snacks.map {
            return [
                "id": $0.key.id ?? 0,
                "quantity": $0.value
            ]
        }
    }
    
    func getSnackRequest() -> [SnackRequest] {
        return snacks.map{ sn in
            return SnackRequest(id: sn.key.id, quantity: sn.value)
        }
    }
}
