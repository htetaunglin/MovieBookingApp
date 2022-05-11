//
//  CinemaObject.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 07/05/2022.
//

import Foundation
import RealmSwift

class CinemaObject: Object {
    @Persisted(primaryKey: true)
    var id: Int
    @Persisted
    var name: String?
    @Persisted
    var phone: String?
    @Persisted
    var email: String?
    @Persisted
    var address: String?
}

extension CinemaObject {
    func toCinema() -> Cinema {
        return Cinema(id: id, name: name, phone: phone, email: email, address: address)
    }
}
