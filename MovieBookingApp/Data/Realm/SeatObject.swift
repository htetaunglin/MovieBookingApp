//
//  SeatObjects.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 11/05/2022.
//

import Foundation
import RealmSwift

class SeatObject : Object{
    @Persisted(primaryKey: true)
    var seatID: String
    @Persisted
    var id: Int
    @Persisted
    var type: String
    @Persisted
    var seatName: String
    @Persisted
    var symbol: String
    @Persisted
    var price: Double
    @Persisted
    var date: String
}

extension SeatObject {
    func toSeat() -> Seat {
        return Seat(id: id, type: type, seatName: seatName, symbol: symbol, price: price)
    }
}
