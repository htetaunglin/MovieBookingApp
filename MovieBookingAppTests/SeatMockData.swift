//
//  SeatMockData.swift
//  MovieBookingAppTests
//
//  Created by Htet Aung Lin on 13/07/2022.
//

import Foundation

public final class SeatMockData {
    static let seatDataResponse: URL = Bundle(for: SeatMockData.self).url(forResource: "seat_data", withExtension: "json")!
}
