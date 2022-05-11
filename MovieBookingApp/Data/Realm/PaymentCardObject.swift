//
//  PaymentCardObject.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 07/05/2022.
//

import Foundation
import RealmSwift

class PaymentCardObject: Object {
    @Persisted(primaryKey: true)
    var id: Int
    @Persisted
    var cardHolder: String
    @Persisted
    var cardNumber: String
    @Persisted
    var cardType: String
    @Persisted
    var expireDate: String
}

extension PaymentCardObject {
    func toPaymentCard() -> PaymentCard {
        return PaymentCard(id: id, cardHolder: cardHolder, cardNumber: cardNumber, cardType: cardType, expireDate: expireDate)
    }
}
