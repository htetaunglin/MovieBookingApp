//
//  CinemaModel.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 30/04/2022.
//

import Foundation

protocol CinemaModel {
    func getCinemas(completion: @escaping (MBAResult<[Cinema]>) -> Void)
    func getCinemaById(cinemaId: Int, completion: @escaping (MBAResult<Cinema>) -> Void)
    func getTimeSlots(movieId: Int, date: String, completion: @escaping (MBAResult<[CinemaTimeSlot]>) -> Void)
}

class CinemaModelImpl: BaseModel, CinemaModel {    
    static let shared = CinemaModelImpl()
    private override init(){}
    
    private let cinemaRepo: CinemaRepository = CinemaRepositoryImpl.shared
    private let timeSlotRepo: CinemaTimeSlotRepository = CinemaTimeSlotRepositoryImpl.shared
    
    func getCinemas(completion: @escaping (MBAResult<[Cinema]>) -> Void) {
        // Get Data From Realm
        cinemaRepo.getCinemas {
            completion(.success($0))
        }
        // Get Data From Network
        networkAgent.getCinemas{[weak self] result in
            switch result {
            case .success(let response):
                // Save data to Realm
                self?.cinemaRepo.saveCinemas(cinemas: response.data ?? [])
                completion(.success(response.data ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getTimeSlots(movieId: Int, date: String, completion: @escaping (MBAResult<[CinemaTimeSlot]>) -> Void) {
        timeSlotRepo.getCinemaTimeSlotsByMovie(movieId: movieId, date: date) {
            completion(.success($0))
        }
        if let token = UserModelImpl.userToken {
            networkAgent.getTimeSlots(token: token, movieId: movieId, date: date){ [weak self] result in
                switch result {
                case .success(let response):
                    self?.timeSlotRepo.saveCinemaTimeSlots(movieId: movieId, date: date, timeSlots: (response.data ?? []))
                    completion(.success(response.data ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure("Token not found"))
        }
       
    }
    
    func getCinemaById(cinemaId: Int, completion: @escaping (MBAResult<Cinema>) -> Void) {
        cinemaRepo.getCinemaById(cinemaId: cinemaId){ cinema in
            if let c = cinema {
                completion(.success(c))
            } else {
                completion(.failure("Cinema not found"))
            }
        }
    }
}
