//
//  UserStore.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 23/04/2022.
//

import Foundation

protocol UserModel {
    static var userToken: String? { get }
    var user: User? { get }
    func getCurrentUser(completion: @escaping (MBAResult<User>) -> Void);
}

class UserModelImpl: BaseModel, UserModel {
    static let shared = UserModelImpl()
    private override init(){}
    
    private let userRepo: UserRepository = UserRepositoryImpl.shared

    var user: User?
    
    static var userToken: String? {
        get {
            let defaults = UserDefaults.standard
            return defaults.string(forKey: "user-token")
        }
    }
    
    func getCurrentUser(completion: @escaping (MBAResult<User>) -> Void) {
        if let currentUser = user {
            userRepo.getUser(id: currentUser.id){
                if let u = $0 {
                    completion(.success(u))
                }
            }
        }
        if let token = UserModelImpl.userToken{
            networkAgent.getProfile(token: token){ [weak self] result in
                switch result {
                case .success(let response):
                    if let user = response.data {
                        self?.userRepo.saveUser(user: user)
                        self?.user = user
                        completion(.success(user))
                    } else {
                        completion(.failure("User not found"))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure("User token not found"))
        }
        
    }
}
