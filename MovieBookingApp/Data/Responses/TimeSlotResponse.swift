// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cinemaTimeSlot = try? newJSONDecoder().decode(CinemaTimeSlot.self, from: jsonData)

import Foundation

// MARK: - CinemaTimeSlot
struct CinemaTimeSlot: Codable {
    let cinemaID: Int
    let cinema: String?
    let timeslots: [Timeslot]?

    enum CodingKeys: String, CodingKey {
        case cinemaID = "cinema_id"
        case cinema, timeslots
    }
}

extension CinemaTimeSlot {
    func toCinemaTimeSlotObject(movieId: Int, date: String) -> CinemaTimeSlotObject {
        let object = CinemaTimeSlotObject()
        object.id = "\(movieId)\(cinemaID)\(date)"
        object.movieId = movieId
        object.date = date
        object.cinemaID = cinemaID
        object.cinema = cinema
        object.timeslots.append(objectsIn: timeslots?.map{ $0.toTimeSlotObject() } ?? [])
        return object
    }
}

// MARK: - Timeslot
struct Timeslot: Codable {
    let cinemaDayTimeslotID: Int
    let startTime: String?

    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case startTime = "start_time"
    }
}


extension Timeslot {
    func toTimeSlotObject() -> TimeSlotObject {
        let object = TimeSlotObject()
        object.cinemaDayTimeslotID = cinemaDayTimeslotID
        object.startTime = startTime
        return object
    }
}
