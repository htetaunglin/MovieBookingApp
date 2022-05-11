//
//  PaymentObject.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 08/05/2022.
//

import Foundation
import RealmSwift

class PaymentMethodObject: Object {
    @Persisted(primaryKey: true)
    var id: Int
    @Persisted
    var name: String?
    @Persisted
    var paymentMethodDescription: String?
}

extension PaymentMethodObject {
    func toPaymentMethod() -> PaymentMethod {
        return PaymentMethod(id: id, name: name, paymentMethodDescription: paymentMethodDescription)
    }
}
