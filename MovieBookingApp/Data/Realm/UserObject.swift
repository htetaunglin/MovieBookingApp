//
//  UserObject.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 07/05/2022.
//

import Foundation
import RealmSwift

class UserObject: Object {
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var name: String?
    
    @Persisted
    var email: String?
    
    @Persisted
    var phone: String?
    
    @Persisted
    var totalExpense: Int?
    
    @Persisted
    var profileImage: String?
    
    @Persisted
    var googleId: String?
    
    @Persisted
    var facebookId: String?
    
    @Persisted
    var paymentCard: List<PaymentCardObject>
}


extension UserObject {
    func toUser() -> User {
        return User(id: id, name: name, email: email, phone: phone, totalExpense: totalExpense, profileImage: profileImage, googleId: googleId, facebookId: facebookId, paymentCard: paymentCard.map{ $0.toPaymentCard() })
    }
}
