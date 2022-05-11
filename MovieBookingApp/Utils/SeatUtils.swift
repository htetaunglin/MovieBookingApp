//
//  SeatUtils.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 11/05/2022.
//

import Foundation

class SeatUtils {
    static func to2DArraySeats(_ seats: [Seat]) -> [[Seat]] {
        var finalResult = [[Seat]]()
        var seatDictionary: [String: [Seat]] = [:]
        seats.forEach {
            if seatDictionary[$0.symbol] == nil {
                seatDictionary[$0.symbol] = [Seat]()
            }
            seatDictionary[$0.symbol]?.append($0)
        }
        let keys = seatDictionary.keys.sorted()
        debugPrint(keys)
        keys.forEach{ key in
            if let value = seatDictionary[key] {
                finalResult.append(value)
            }
        }
        return finalResult
    }
    
    static func to1DArraySeats(_ seats: [[Seat]]) -> [Seat] {
        return Array(seats.joined())
    }
}
