// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let paymentMethod = try? newJSONDecoder().decode(PaymentMethod.self, from: jsonData)

import Foundation

// MARK: - PaymentMethod
struct PaymentMethod: Codable {
    let id: Int?
    let name, paymentMethodDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case paymentMethodDescription = "description"
    }
}
