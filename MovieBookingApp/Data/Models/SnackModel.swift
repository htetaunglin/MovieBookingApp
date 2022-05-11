//
//  SnackModel.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 06/05/2022.
//

import Foundation

protocol SnackModel {
    func getSnacks(completion: @escaping (MBAResult<[Snack]>) -> Void)
}

class SnackModelImpl: BaseModel, SnackModel {
    static let shared = SnackModelImpl()
    private override init(){}
    
    private let snackRepo: SnackRepository = SnackRepositoryImpl.shared
    
    func getSnacks(completion: @escaping (MBAResult<[Snack]>) -> Void) {
        // Get Data from Realm
        snackRepo.getSnacks{
            completion(.success($0))
        }
        // Get Data from Network
        if let token = UserModelImpl.userToken {
            networkAgent.getSnacks(token: token){[weak self] result in
                switch result {
                case .success(let response):
                    // Save data to Realm
                    self?.snackRepo.saveSnacks(snack: response.data ?? [])
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
