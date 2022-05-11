//
//  TimeSlotObject.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 08/05/2022.
//

import Foundation
import RealmSwift

class TimeSlotObject: Object {
    @Persisted(primaryKey: true)
    var cinemaDayTimeslotID: Int
    @Persisted
    var startTime: String?
    @Persisted
    var seats: List<SeatObject>
}

extension TimeSlotObject {
    func toTimeSlot() -> Timeslot {
        return Timeslot(cinemaDayTimeslotID: cinemaDayTimeslotID, startTime: startTime)
    }
}
