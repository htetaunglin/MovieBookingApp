//
//  MovieModel.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 28/04/2022.
//

import Foundation

protocol MovieModel {
    func getShowingMovies(take: Int, completation: @escaping(MBAResult<[Movie]>) -> Void)
    func getComingMovies(take: Int, completation: @escaping(MBAResult<[Movie]>) -> Void)
    func getMovieById(id: Int, completation: @escaping(MBAResult<Movie>) -> Void)
}

class MovieModelImpl: BaseModel, MovieModel {
    static let shared = MovieModelImpl()
    private override init(){}
    
    func getShowingMovies(take: Int, completation: @escaping (MBAResult<[Movie]>) -> Void) {
        networkAgent.getMovies(status: "current", take: take) { result in
            switch result {
            case .success(let response):
                completation(.success(response.data ?? []))
            case .failure(let error):
                completation(.failure(error))
            }
        }
    }
    
    func getComingMovies(take: Int, completation: @escaping (MBAResult<[Movie]>) -> Void) {
        networkAgent.getMovies(status: "comingsoon", take: take) { result in
            switch result {
            case .success(let response):
                completation(.success(response.data ?? []))
            case .failure(let error):
                completation(.failure(error))
            }
        }
    }
    func getMovieById(id: Int, completation: @escaping (MBAResult<Movie>) -> Void) {
        networkAgent.getMovieById(id: id){ result in
            switch result {
            case .success(let response):
                if let movie = response.data {
                    completation(.success(movie))
                } else {
                    completation(.failure("Invalid Movie id"))
                }
            case .failure(let error):
                completation(.failure(error))
            }
        }
    }
}
