//
//  BookingInfoObject.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 12/05/2022.
//

import Foundation
import RealmSwift

class BookingInfoObject: Object {
    @Persisted(primaryKey: true)
    var movieId: Int
    @Persisted
    var movie: MovieObject?
    @Persisted
    var cinemaDayTimeSlot: TimeSlotObject?
    @Persisted
    var seats: List<SeatObject>
    @Persisted
    var date: Date?
    @Persisted
    var card: PaymentCardObject?
    @Persisted
    var cinema: CinemaObject?
    @Persisted
    var snacks: List<BookingSnackObject>
}

class BookingSnackObject: Object {
    @Persisted(primaryKey: true)
    var snackId: Int
    @Persisted
    var snack: SnackObject?
    @Persisted
    var quantity: Int
}

extension BookingInfoObject {
    func totalCharges() -> Double {
        let seatPrice = seats.reduce(0.0) { $0 + $1.price }
        let snackPrice = snacks.reduce(0.0) { $0 + (Double($1.quantity) * ($1.snack?.price ?? 0.0)) }
        return seatPrice + snackPrice
    }
}


extension BookingSnackObject {
    func toSnackRequest() -> SnackRequest {
        SnackRequest(id: snack?.id, quantity: quantity)
    }
}
