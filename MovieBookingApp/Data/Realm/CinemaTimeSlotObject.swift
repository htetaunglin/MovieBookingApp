//
//  CinemaTimeSlotObject.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 08/05/2022.
//

import Foundation
import RealmSwift

class CinemaTimeSlotObject: Object {
    @Persisted(primaryKey: true)
    var id: String
    @Persisted
    var movieId: Int
    @Persisted
    var date: String
    @Persisted
    var cinemaID: Int
    @Persisted
    var cinema: String?
    @Persisted
    var timeslots: List<TimeSlotObject>
}

extension CinemaTimeSlotObject {
    func toCinemaTimeSlot() -> CinemaTimeSlot {
        return CinemaTimeSlot(cinemaID: cinemaID, cinema: cinema, timeslots: timeslots.map{ $0.toTimeSlot() } )
    }
}
