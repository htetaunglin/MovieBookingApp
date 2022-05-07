//
//  PaymentCardResponse.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 07/05/2022.
//

import Foundation

// MARK: - PaymentCard
struct PaymentCard: Codable {
    let id: Int
    let cardHolder, cardNumber, cardType: String
    let expireDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case cardHolder = "card_holder"
        case cardNumber = "card_number"
        case cardType = "card_type"
        case expireDate = "expiration_date"
    }
}
