// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let seat = try? newJSONDecoder().decode(Seat.self, from: jsonData)

import Foundation

// MARK: - Seat
struct Seat: Codable {
    let id: Int?
    let type, seatName, symbol: String?
    let price: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, type
        case seatName = "seat_name"
        case symbol, price
    }
}

extension Seat {
    func isMovieSeatAvailable() -> Bool{
        return type == SEAT_TYPE_AVAILABLE
    }
    
    func isMovieSeatTaken() -> Bool{
        return type == SEAT_TYPE_TAKEN
    }
    
    func isMovieSeatRowTitle() -> Bool{
        return type == SEAT_TYPE_TEXT
    }
    
    func isMovieSeatSpace() -> Bool{
        return type == SEAT_TYPE_SPACE
    }
}
