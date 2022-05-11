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
    
    private let movieRepo: MovieRepository = MovieRepositoryImpl.shared
    
    func getShowingMovies(take: Int, completation: @escaping (MBAResult<[Movie]>) -> Void) {
        // Get Data From Realm
        movieRepo.getShowingMovies {
            completation(.success($0))
        }
        // Get Data From Network
        networkAgent.getMovies(status: "current", take: take) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movieRepo.saveShowingMovie(movies: response.data ?? [])
                completation(.success(response.data ?? []))
            case .failure(let error):
                completation(.failure(error))
            }
        }
    }
    
    func getComingMovies(take: Int, completation: @escaping (MBAResult<[Movie]>) -> Void) {
        // Get Data From Realm
        movieRepo.getComingMovies {
            completation(.success($0))
        }
        // Get Data From Network
        networkAgent.getMovies(status: "comingsoon", take: take) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movieRepo.saveComingMovie(movies: response.data ?? [])
                completation(.success(response.data ?? []))
            case .failure(let error):
                completation(.failure(error))
            }
        }
    }
    func getMovieById(id: Int, completation: @escaping (MBAResult<Movie>) -> Void) {
        // Get Data From Realm
        movieRepo.getMovieDetail(id: id) { movie in
            if let m = movie {
                completation(.success(m))
            }
        }
        // Get Data From Network
        networkAgent.getMovieById(id: id){[weak self] result in
            switch result {
            case .success(let response):
                if let movie = response.data {
                    self?.movieRepo.saveMovieDetail(movie: movie)
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
