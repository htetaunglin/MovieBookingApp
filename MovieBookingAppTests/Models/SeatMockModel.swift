//
//  SeatModelTest.swift
//  MovieBookingAppTests
//
//  Created by Htet Aung Lin on 13/07/2022.
//

@testable import MovieBookingApp
import Foundation

class SeatMockModelImpl : SeatModel {
    
    func getSeat(timeSlotId: Int, date: String, completion: @escaping (MBAResult<[[Seat]]>) -> Void) {
        let seatDataJson: Data = try! Data(contentsOf: SeatMockData.seatDataResponse)
        let response: BaseResponse<[[Seat]]> = try! JSONDecoder().decode(BaseResponse.self, from: seatDataJson)
        completion(.success(response.data ?? []))
    }
}

class SeatMockErrorModelImpl: SeatModel {
    func getSeat(timeSlotId: Int, date: String, completion: @escaping (MBAResult<[[Seat]]>) -> Void) {
        completion(.failure("The given data was invalid."))
    }
}
