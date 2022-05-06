//
//  NetworkAgent.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 23/04/2022.
//

import Foundation
import Alamofire

class NetworkAgent: NetworkAgentProtocol {
    
    static let shared = NetworkAgent()
    private init(){}
    
    func signUpWithEmail(name: String, email: String, phone: String, password: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void) {
        let param = [
            "name": name,
            "email": email,
            "phone": phone,
            "password": password
        ]
        AF.request(NetworkEndPoint.signUp,
                   method: .post,
                   parameters: param,
                   encoder: URLEncodedFormParameterEncoder.default)
        .customDecodable(completion: completion)
    }
    
    func signUpWithGoogle(googleToken: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void) {
        
    }
    
    func signUpWithFacebook(facebookToken: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void) {
        
    }
    
    func loginWithEmail(email: String, password: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void) {
        let param = [
            "email": email,
            "password": password
        ]
        AF.request(NetworkEndPoint.signIn,
                   method: .post,
                   parameters: param,
                   encoder: URLEncodedFormParameterEncoder.default)
        .customDecodable(completion: completion)
    }
    
    func loginWithGoogle(googleToken: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void) {
        
    }
    
    func loginWithFacebook(facebookToken: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void) {
        
    }
    
    
    func logout(token: String, completion: @escaping (MBAResult<BaseResponse<NullCodable?>>) -> Void) {
        let headers = HTTPHeaders([
            HTTPHeader(name: "Authorization", value: "Bearer \(token)")
        ])
        AF.request(NetworkEndPoint.logout, method: .post, headers: headers).customDecodable(completion: completion)
    }
    
    
    func getProfile(token: String, completion: @escaping (MBAResult<BaseResponse<User>>) -> Void) {
        let headers = HTTPHeaders([
            HTTPHeader(name: "Authorization", value: "Bearer \(token)")
        ])
        AF.request(NetworkEndPoint.profile, headers: headers).customDecodable(completion: completion)
    }
    
    func getMovies(status: String, take: Int, completion: @escaping (MBAResult<BaseResponse<[Movie]>>) -> Void) {
        AF.request(NetworkEndPoint.movie(status: status, take: take)).customDecodable(completion: completion)
    }
    
    func getMovieById(id: Int, completion: @escaping (MBAResult<BaseResponse<Movie>>) -> Void) {
        AF.request(NetworkEndPoint.movieById(id: id)).customDecodable(completion: completion)
    }
    
    func getCinemas(completion: @escaping (MBAResult<BaseResponse<[Cinema]>>) -> Void) {
        AF.request(NetworkEndPoint.cinema).customDecodable(completion: completion)
    }
    
    func getTimeSlots(token: String, movieId: Int, date: String, completion: @escaping (MBAResult<BaseResponse<[CinemaTimeSlot]>>) -> Void) {
        let headers = HTTPHeaders([
            HTTPHeader(name: "Authorization", value: "Bearer \(token)")
        ])
        AF.request(NetworkEndPoint.timeslot(movieId: movieId, date: date), headers: headers).customDecodable(completion: completion)
    }
    
    func getSeats(token: String, timeSlotId: Int, date: String, completion: @escaping (MBAResult<BaseResponse<[[Seat]]>>) -> Void) {
        let headers = HTTPHeaders([
            HTTPHeader(name: "Authorization", value: "Bearer \(token)")
        ])
        AF.request(NetworkEndPoint.seat(timeSlotId: timeSlotId, date: date), headers: headers).customDecodable(completion: completion)
    }
}


protocol NetworkErrorModel: Decodable {
    var message : String { get }
}

class NetworkCommonResponseError: NetworkErrorModel {
    var message: String {
        return statusMessage
    }
    
    let statusMessage: String
    let statusCode : Int
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "message"
        case statusCode = "code"
    }
}

enum MBAResult<T>{
    case success(T)
    case failure(String)
}

extension DataRequest {
    func customDecodable<T: Codable>(completion: @escaping (MBAResult<BaseResponse<T>>) -> Void){
        self.responseDecodable(of: BaseResponse<T>.self){ response in
                switch response.result {
                case .success(let data):
                    if let code = data.code {
                        if code >= 200 && code < 300 {
                            completion(.success(data))
                        } else {
                            completion(.failure(data.message ?? "Something is wrong"))
                        }
                    }
                case .failure(let error):
                    completion(.failure(handleError(response, error, NetworkCommonResponseError.self)))
                }
            }
    }
}


fileprivate func handleError<T, E: NetworkErrorModel>(
    _ response : DataResponse<T, AFError>,
    _ error: AFError,
    _ errorBodyType : E.Type) -> String {
        
        var resBody: String = ""
        var serverErrorMessage: String?
        var errorBody: E?
        
        if let responseData = response.data {
            resBody = String(data: responseData, encoding: .utf8) ?? "empty response body"
            errorBody = try? JSONDecoder().decode(errorBodyType, from: responseData)
            serverErrorMessage = errorBody?.message
        }
        
        let respCode: Int = response.response?.statusCode ?? 0
        let sourcePath: String = response.request?.url?.absoluteString ?? ""
        
        print("""
        ===================
        URL
        -> \(sourcePath)
        Status
        -> \(respCode)
        Body
        -> \(resBody)
        Underlying Error
        -> \(String(describing: error.underlyingError))
        Error Description
        -> \(error.errorDescription!)
        ===================
        """)
        
        return serverErrorMessage ?? error.errorDescription ?? "undefined"
    }
