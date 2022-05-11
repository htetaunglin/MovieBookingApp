//
//  UserRepository.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 23/04/2022.
//

import Foundation

protocol UserRepository {
    func saveUser(user: User)
    func getUser(id: Int, completion: @escaping (User?) -> Void)
    func savePaymentCards(userId: Int, paymentCards: [PaymentCard])
}


class UserRepositoryImpl: BaseRepository, UserRepository {
    static let shared: UserRepository = UserRepositoryImpl()
    private override init() {
        super.init()
    }
    
    func saveUser(user: User) {
        do {
            try realmDB.write {
                realmDB.add(user.toUserObject(), update: .modified)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func getUser(id: Int, completion: @escaping (User?) -> Void) {
        let user = realmDB.object(ofType: UserObject.self, forPrimaryKey: id)
        completion(user?.toUser())
    }
    
    func savePaymentCards(userId: Int, paymentCards: [PaymentCard]) {
        let user = realmDB.object(ofType: UserObject.self, forPrimaryKey: userId)
        do {
            try realmDB.write {
                let objects = paymentCards.map{ $0.toPaymentCardObject() }
                realmDB.add(objects, update: .modified)
                user?.paymentCard.append(objectsIn: paymentCards.map{ $0.toPaymentCardObject() })
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
