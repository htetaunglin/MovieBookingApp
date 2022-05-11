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
    
    private let seatRepo: SeatRepository = SeatRepositoryImpl.shared
    
    func getSeat(timeSlotId: Int, date: String, completion: @escaping (MBAResult<[[Seat]]>) -> Void) {
//        seatRepo.getSeats(timeSlotId: timeSlotId, date: date) { seats in
//            completion(.success(SeatUtils.to2DArraySeats(seats)))
//        }
        if let token = UserModelImpl.userToken {
            networkAgent.getSeats(token: token, timeSlotId: timeSlotId, date: date){ [weak self] result in
                switch result {
                case .success(let response):
                    self?.seatRepo.saveSeats(timeSlotId: timeSlotId, date: date, seats: SeatUtils.to1DArraySeats(response.data ?? []))
                    completion(.success(response.data ?? []))
                case .failure(let error):
                    self?.seatRepo.getSeats(timeSlotId: timeSlotId, date: date) { seats in
                        if seats.isEmpty {
                            completion(.failure(error))
                        }  else {
                            // One dimension to Two dimension
                            completion(.success(SeatUtils.to2DArraySeats(seats)))
                        }
                    }

                }
            }
        } else {
            completion(.failure("Token not found"))
        }
    }
}
