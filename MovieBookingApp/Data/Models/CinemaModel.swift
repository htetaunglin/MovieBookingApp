//
//  CinemaModel.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 30/04/2022.
//

import Foundation

protocol CinemaModel {
    func getCinemas(completion: @escaping (MBAResult<[Cinema]>) -> Void)
    func getTimeSlots(movieId: Int, date: String, completion: @escaping (MBAResult<[Cinema]>) -> Void)
}

class CinemaModelImpl: BaseModel, CinemaModel {    
    static let shared = CinemaModelImpl()
    private override init(){}
    
    func getCinemas(completion: @escaping (MBAResult<[Cinema]>) -> Void) {
        networkAgent.getCinemas{ result in
            switch result {
            case .success(let response):
                completion(.success(response.data ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTimeSlots(movieId: Int, date: String, completion: @escaping (MBAResult<[Cinema]>) -> Void) {
        networkAgent.getTimeSlots(movieId: movieId, date: date){ result in
            switch result {
            case .success(let response):
                completion(.success(response.data ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
