// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ticketRequest = try? newJSONDecoder().decode(TicketRequest.self, from: jsonData)

import Foundation

// MARK: - TicketRequest
struct TicketRequest: Codable {
    let cinemaDayTimeslotID: Int?
    let row, seatNumber, bookingDate: String?
    let totalPrice: Double?
    let movieID, cardID, cinemaID: Int?
    let snacks: [SnackRequest]?

    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case row
        case seatNumber = "seat_number"
        case bookingDate = "booking_date"
        case totalPrice = "total_price"
        case movieID = "movie_id"
        case cardID = "card_id"
        case cinemaID = "cinema_id"
        case snacks
    }
}

// MARK: - Snack
struct SnackRequest: Codable {
    let id, quantity: Int?
}
