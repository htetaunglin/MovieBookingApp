//
//  AuthModel.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 22/04/2022.
//

import Foundation

protocol AuthModel {
    static var isLoggedIn: Bool { get }
    func signUpWithEmail(name: String, email: String, phone: String, password: String, completion: @escaping (MBAResult<User>) -> Void)
    func signUpWithGoogle(googleToken: String, completion: @escaping (MBAResult<User>) -> Void)
    func signUpWithFacebook(facebookToken: String, completion: @escaping (MBAResult<User>) -> Void)
    func loginWithEmail(email: String, password: String, completion: @escaping (MBAResult<User>) -> Void)
    func loginWithGoogle(googleToken: String, completion: @escaping (MBAResult<User>) -> Void)
    func loginWithFacebook(facebookToken: String, completion: @escaping (MBAResult<User>) -> Void)
    func logout(completion: @escaping (MBAResult<String>) -> Void)
}

class AuthModelImpl: BaseModel, AuthModel {
    
    static let shared = AuthModelImpl()
    private override init(){}
    
    private let userRepo: UserRepository = UserRepositoryImpl.shared
    
    static var isLoggedIn: Bool {
        get {
            return UserModelImpl.userToken != nil
        }
    }
    
    func signUpWithEmail(name: String, email: String, phone: String, password: String, completion: @escaping (MBAResult<User>) -> Void) {
        networkAgent.signUpWithEmail(name: name, email: email, phone: phone, password: password) { [weak self] result in
            switch result {
            case .success(let response):
                // Set to User Default
                let defaults = UserDefaults.standard
                defaults.set(response.token, forKey: "user-token")
                if let user = response.data {
                    self?.userRepo.saveUser(user: user)
                    completion(.success(user))
                } else {
                    completion(.failure("User not found"))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    func signUpWithGoogle(googleToken: String, completion: @escaping (MBAResult<User>) -> Void) {
        
    }
    
    func signUpWithFacebook(facebookToken: String, completion: @escaping (MBAResult<User>) -> Void) {
        
    }
    
    func loginWithEmail(email: String, password: String, completion: @escaping (MBAResult<User>) -> Void) {
        networkAgent.loginWithEmail(email: email, password: password){[weak self] result in
            switch result {
            case .success(let response):
                // Set to User Default
                let defaults = UserDefaults.standard
                defaults.set(response.token, forKey: "user-token")
                if let user = response.data {
                    self?.userRepo.saveUser(user: user)
                    completion(.success(user))
                } else {
                    completion(.failure("User not found"))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loginWithGoogle(googleToken: String, completion: @escaping (MBAResult<User>) -> Void) {
        
    }
    
    func loginWithFacebook(facebookToken: String, completion: @escaping (MBAResult<User>) -> Void) {
        
    }
    
    func logout(completion: @escaping (MBAResult<String>) -> Void) {
        if let token = UserModelImpl.userToken {
            networkAgent.logout(token: token){ result in
                switch result {
                case .success(let res):
                    let defaults = UserDefaults.standard
                    defaults.removeObject(forKey: "user-token")
                    completion(.success(res.message ?? "successful logout"))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure("User token not found"))
        }
        
    }
}
