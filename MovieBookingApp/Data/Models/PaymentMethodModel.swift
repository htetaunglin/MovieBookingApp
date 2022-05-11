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
    
    private let paymentMethodRepo: PaymentMethodRepository = PaymentMethodRepositoryImpl.shared
    
    func getPaymentMethods(completion: @escaping (MBAResult<[PaymentMethod]>) -> Void) {
        // Get data from Realm
        paymentMethodRepo.getPaymentMethods {
            completion(.success($0))
        }
        // Get data from Network
        if let token = UserModelImpl.userToken {
            networkAgent.getPaymentMethod(token: token){ [weak self] result in
                switch result {
                case .success(let response):
                    // Save data to Realm
                    self?.paymentMethodRepo.savePaymentMethods(methods: response.data ?? [])
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
