// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cinemaTimeSlot = try? newJSONDecoder().decode(CinemaTimeSlot.self, from: jsonData)

import Foundation

// MARK: - CinemaTimeSlot
struct CinemaTimeSlot: Codable {
    let cinemaID: Int?
    let cinema: String?
    let timeslots: [Timeslot]?

    enum CodingKeys: String, CodingKey {
        case cinemaID = "cinema_id"
        case cinema, timeslots
    }
}

// MARK: - Timeslot
struct Timeslot: Codable {
    let cinemaDayTimeslotID: Int?
    let startTime: String?

    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case startTime = "start_time"
    }
}
