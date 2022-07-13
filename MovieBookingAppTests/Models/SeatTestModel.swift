//
//  SeatModelTest.swift
//  MovieBookingAppTests
//
//  Created by Htet Aung Lin on 13/07/2022.
//

@testable import MovieBookingApp
import Foundation

class SeatTestModelImpl : SeatModel {
    static let shared = SeatTestModelImpl()
    private init(){}
    
    func getSeat(timeSlotId: Int, date: String, completion: @escaping (MBAResult<[[Seat]]>) -> Void) {
        let seatDataJson: Data = try! Data(contentsOf: SeatMockData.seatDataResponse)
        do {
            let response: BaseResponse<[[Seat]]> = try JSONDecoder().decode(BaseResponse.self, from: seatDataJson)
            completion(.success(response.data ?? []))
        } catch {
            print(error.localizedDescription)
            completion(.failure(error.localizedDescription))
        }
        
    }
}
