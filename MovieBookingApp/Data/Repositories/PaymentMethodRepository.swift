//
//  PaymentMethodRepository.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 08/05/2022.
//

import Foundation

protocol PaymentMethodRepository {
    func savePaymentMethods(methods: [PaymentMethod])
    func getPaymentMethods(completion: @escaping ([PaymentMethod]) -> Void)
}

class PaymentMethodRepositoryImpl: BaseRepository, PaymentMethodRepository {
    static let shared: PaymentMethodRepository = PaymentMethodRepositoryImpl()
    private override init() {
        super.init()
    }
    
    func savePaymentMethods(methods: [PaymentMethod]) {
        do {
            try realmDB.write {
                realmDB.add(methods.map{ $0.toPaymentMethodObject() }, update: .modified)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func getPaymentMethods(completion: @escaping ([PaymentMethod]) -> Void) {
        let object = realmDB.objects(PaymentMethodObject.self)
        completion(object.map{ $0.toPaymentMethod() })
    }
    
}
