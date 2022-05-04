//
//  CinemaResponse.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 29/04/2022.
//

import Foundation

// MARK: - Cinema
struct Cinema: Codable {
    let id: Int?
    let name, phone, email, address: String?
}
