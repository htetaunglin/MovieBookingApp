//
//  CinemaResponse.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 29/04/2022.
//

import Foundation

// MARK: - Cinema
struct Cinema: Codable {
    let id: Int
    let name, phone, email, address: String?
}

extension Cinema {
    func toCinemaObject() -> CinemaObject {
        let cinemaObj = CinemaObject()
        cinemaObj.id = id
        cinemaObj.name = name
        cinemaObj.phone = phone
        cinemaObj.email = email
        cinemaObj.address = address
        return cinemaObj
    }
}
