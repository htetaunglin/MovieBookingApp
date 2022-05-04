// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let authResponse = try? newJSONDecoder().decode(AuthResponse.self, from: jsonData)

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int?
    let name, email, phone: String?
    let totalExpense: Int?
    let profileImage: String?
    let googleId, facebookId: String?
    let paymentCard: [PaymentCard]?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone
        case totalExpense = "total_expense"
        case profileImage = "profile_image"
        case googleId = "google_id"
        case facebookId = "facebook_id"
        case paymentCard = "cards"
    }
}

// MARK: - PaymentCard
struct PaymentCard: Codable {
    let id: Int?
    let cardHolder, cardNumber, cardType: String?
    let image: String?
    let amount: String?

    enum CodingKeys: String, CodingKey {
        case id
        case cardHolder = "card_holder"
        case cardNumber = "card_number"
        case cardType = "card_type"
        case image, amount
    }
}

