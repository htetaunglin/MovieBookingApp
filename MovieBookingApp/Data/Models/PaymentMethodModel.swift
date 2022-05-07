//
//  PaymentMethodModel.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 06/05/2022.
//

import Foundation

protocol PaymentMethodModel {
    func getPaymentMethods(completion: @escaping (MBAResult<[PaymentMethod]>) -> Void)
}

class PaymentMethodModelImpl: BaseModel, PaymentMethodModel {
    static let shared = PaymentMethodModelImpl()
    private override init(){}
    
    
    func getPaymentMethods(completion: @escaping (MBAResult<[PaymentMethod]>) -> Void) {
        if let token = UserModelImpl.userToken {
            networkAgent.getPaymentMethod(token: token){ result in
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
