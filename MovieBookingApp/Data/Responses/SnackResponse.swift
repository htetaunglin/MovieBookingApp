// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let snack = try? newJSONDecoder().decode(Snack.self, from: jsonData)

import Foundation

// MARK: - Snack
struct Snack: Codable, Hashable {
    let id: Int
    let name, snackDescription: String?
    let price: Double?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case snackDescription = "description"
        case price, image
    }
}

extension Snack {
    func toSnackObject() -> SnackObject {
        let snackObj = SnackObject()
        snackObj.id = id
        snackObj.name = name
        snackObj.snackDescription = snackDescription
        snackObj.price = price
        snackObj.image = image
        return snackObj
    }
}
