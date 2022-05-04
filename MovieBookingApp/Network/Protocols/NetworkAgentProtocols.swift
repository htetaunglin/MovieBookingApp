//
//  AuthProtocols.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 22/04/2022.
//

import Foundation

protocol NetworkAgentProtocol {
    
    // MARK: - Authorization
    func signUpWithEmail(name: String, email: String, phone: String, password: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void)
    func signUpWithGoogle(googleToken: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void)
    func signUpWithFacebook(facebookToken: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void)
    func loginWithEmail(email: String, password: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void)
    func loginWithGoogle(googleToken: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void)
    func loginWithFacebook(facebookToken: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void)
    func logout(token: String, completion: @escaping (MBAResult<BaseResponse<NullCodable?>>) -> Void)
    
    // MARK: - Profile
    func getProfile(token: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void)
    
    // MARK: - Movie
    func getMovies(status: String, take: Int, completion: @escaping (MBAResult<BaseResponse<[Movie]>>) -> Void)
    func getMovieById(id: Int, completion: @escaping (MBAResult<BaseResponse<Movie>>) -> Void)
    
    // MARK: - Cinema
    func getCinemas(completion: @escaping (MBAResult<BaseResponse<[Cinema]>>) -> Void)
    func getTimeSlots(token: String, movieId: Int, date: String, completion: @escaping (MBAResult<BaseResponse<[CinemaTimeSlot]>>) -> Void)
}
