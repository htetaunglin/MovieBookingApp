//
//  SnackObject.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 08/05/2022.
//

import Foundation
import RealmSwift

class SnackObject: Object {
    @Persisted(primaryKey: true)
    var id: Int
    @Persisted
    var name: String?
    @Persisted
    var snackDescription: String?
    @Persisted
    var price: Double?
    @Persisted
    var image: String?
}

extension SnackObject {
    func toSnack() -> Snack {
        return Snack(id: id, name: name, snackDescription: snackDescription, price: price, image: image)
    }
}
