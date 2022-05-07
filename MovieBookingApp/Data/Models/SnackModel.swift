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
    
    func getSnacks(completion: @escaping (MBAResult<[Snack]>) -> Void) {
        if let token = UserModelImpl.userToken {
            networkAgent.getSnacks(token: token){ result in
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
