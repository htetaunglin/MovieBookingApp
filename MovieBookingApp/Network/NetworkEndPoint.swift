//
//  EndPoint.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 22/04/2022.
//

import Foundation
import Alamofire

enum NetworkEndPoint: URLConvertible {
    case signUp
    case signIn
    case logout
    case profile
    case movie(status: String, take: Int)
    case movieById(id: Int)
    case cinema
    case timeslot(movieId: Int, date: String)
    
    func asURL() throws -> URL {
        return url
    }
    
    var url: URL {
        let urlComponents = NSURLComponents(string: baseURL.appending(apiPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? apiPath))
        return urlComponents!.url!
    }
    
    private var apiPath: String {
        switch self {
        case .signUp:
            return "/api/v1/register"
        case .signIn:
            return "/api/v1/email-login"
        case .logout:
            return "/api/v1/logout"
        case .profile:
            return "/api/v1/profile"
        case .movie(let status, let take):
            return "/api/v1/movies?status=\(status)&take=\(take)"
        case .movieById(let id):
            return "/api/v1/movies/\(id)"
        case .cinema:
            return "/api/v1/cinemas"
        case .timeslot(let movieId, let date):
            return "/api/v1/cinema-day-timeslots?movie_id=\(movieId)&date=\(date)"
        }
    }
}
