// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieTicketResponse = try? newJSONDecoder().decode(MovieTicketResponse.self, from: jsonData)

import Foundation

// MARK: - MovieTicketResponse
struct MovieTicket: Codable {
    let id: Int?
    let bookingNo, bookingDate, row, seat: String?
    let totalSeat: Int?
    let total: String?
    let movieID, cinemaID: Int?
    let username: String?
    let timeslot: Timeslot?
    let snackTickets: [SnackTicket]?
    let qrCode: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingNo = "booking_no"
        case bookingDate = "booking_date"
        case row, seat
        case totalSeat = "total_seat"
        case total
        case movieID = "movie_id"
        case cinemaID = "cinema_id"
        case username
        case timeslot
        case snackTickets = "snacks"
        case qrCode = "qr_code"
    }
}

// MARK: - SnackTicket
struct SnackTicket: Codable {
    let id: Int?
    let name, snackTicketDescription, image: String?
    let price, unitPrice, quantity, totalPrice: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case snackTicketDescription = "description"
        case image, price
        case unitPrice = "unit_price"
        case quantity
        case totalPrice = "total_price"
    }
}
