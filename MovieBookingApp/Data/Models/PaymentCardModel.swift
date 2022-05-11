//
//  PaymentModel.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 07/05/2022.
//

import Foundation

protocol PaymentCardModel {
    func createCard(cardNo: String, holder: String, expire: String, cvc: String, completion: @escaping (MBAResult<[PaymentCard]>) -> Void)
}

class PaymentCardModelImpl: BaseModel, PaymentCardModel {
    
    static let shared = PaymentCardModelImpl()
    private override init(){}
    
    final let userRepo: UserRepository = UserRepositoryImpl.shared
    
    func createCard(cardNo: String, holder: String, expire: String, cvc: String, completion: @escaping (MBAResult<[PaymentCard]>) -> Void) {
        if let token = UserModelImpl.userToken {
            networkAgent.createPaymentCard(token: token, cardNumber: cardNo, holder: holder, expire: expire, cvc: cvc){[weak self] result in
                switch result {
                case .success(let response):
                    if let card = response.data {
                        self?.userRepo.savePaymentCards(userId: UserModelImpl.shared.user?.id ?? 0, paymentCards: card)
                        completion(.success(card))
                    } else {
                        completion(.failure("Cannot create card"))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure("Token not found"))
        }
        
    }
}
