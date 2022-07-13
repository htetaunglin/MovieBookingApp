//
//  BookingInfoResponse.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 13/07/2022.
//

import Foundation

class BookingInfo {
    var movie: Movie?
    var cinemaDayTimeSlot: Timeslot?
    var seats: [Seat]?
    var date: Date?
    var card: PaymentCard?
    var cinema: Cinema?
    var snacks: [BookingSnack]?
}

extension BookingInfo {
    func totalCharges() -> Double {
        let seatPrice = seats?.reduce(0.0) { $0 + ($1.price ?? 0) } ?? 0
        let snackPrice = snacks?.reduce(0.0) { $0 + (Double($1.quantity) * ($1.snack?.price ?? 0.0)) } ?? 0
        return seatPrice + snackPrice
    }
}
