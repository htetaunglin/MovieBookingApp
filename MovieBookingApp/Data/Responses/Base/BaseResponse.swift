//
//  BaseResponse.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 29/04/2022.
//

import Foundation

struct BaseResponse<T :Codable>: Codable {
    let code: Int?
    let message: String?
    let data: T?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case code, message
        case data = "data"
        case token
    }
}

struct NullCodable: Codable {
}
