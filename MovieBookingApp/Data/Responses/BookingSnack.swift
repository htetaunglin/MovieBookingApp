//
//  BookingSnack.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 13/07/2022.
//

import Foundation

struct BookingSnack {
    var snackId: Int
    var snack: Snack?
    var quantity: Int
}

extension BookingSnack {
    func toSnackRequest() -> SnackRequest {
        SnackRequest(id: snack?.id, quantity: quantity)
    }
}
