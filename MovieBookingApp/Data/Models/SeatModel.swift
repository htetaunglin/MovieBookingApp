//
//  SeatModel.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 06/05/2022.
//

import Foundation

protocol SeatModel {
    func getSeat(timeSlotId: Int, date: String, completion: @escaping (MBAResult<[[Seat]]>) -> Void)
}

class SeatModelImpl: BaseModel, SeatModel {
    static let shared = SeatModelImpl()
    private override init(){}
    
    func getSeat(timeSlotId: Int, date: String, completion: @escaping (MBAResult<[[Seat]]>) -> Void) {
        if let token = UserModelImpl.userToken {
            networkAgent.getSeats(token: token, timeSlotId: timeSlotId, date: date){ result in
                switch result {
                case .success(let response):
                    completion(.success(response.data ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure("Token not found"))
        }
    }
}
