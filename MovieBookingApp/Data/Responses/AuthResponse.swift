// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let authResponse = try? newJSONDecoder().decode(AuthResponse.self, from: jsonData)

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int
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

extension User {
    func toUserObject() -> UserObject {
        let userObj = UserObject()
        userObj.id = id
        userObj.name = name
        userObj.email = email
        userObj.phone = phone
        userObj.totalExpense = totalExpense
        userObj.profileImage = profileImage
        userObj.googleId = googleId
        userObj.facebookId = facebookId
        userObj.paymentCard.append(objectsIn: paymentCard?.map{ $0.toPaymentCardObject() } ?? [])
        return userObj
    }
}
