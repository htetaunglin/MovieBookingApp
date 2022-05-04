//
//  CinemaResponse.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 29/04/2022.
//

import Foundation

// MARK: - Cinema
struct Cinema: Codable {
    let id: Int?
    let name, phone, email, address: String?
    let timeSlot: [Timeslot]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, phone, email, address
        case timeSlot = "timeslots"
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
