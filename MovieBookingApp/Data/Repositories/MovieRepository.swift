//
//  MovieRepository.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 08/05/2022.
//

import Foundation

protocol MovieRepository {
    func saveShowingMovie(movies: [Movie])
    func saveComingMovie(movies: [Movie])
    func getShowingMovies(completion: @escaping ([Movie]) -> Void)
    func getComingMovies(completion: @escaping ([Movie]) -> Void)
    
    func saveMovieDetail(movie: Movie)
    func getMovieDetail(id: Int, completion: @escaping (Movie?) -> Void)
}

class MovieRepositoryImpl : BaseRepository, MovieRepository {
    static let shared: MovieRepository = MovieRepositoryImpl()
    private override init() {
        super.init()
    }
    
    func saveShowingMovie(movies: [Movie]) {
        do {
            try realmDB.write{
                let objects = movies.map{ $0.toMovieObject() }
                realmDB.add(objects, update: .modified)
                let blttObj = BelongToTypeObject()
                blttObj.name = "Now Showing"
                blttObj.movies.append(objectsIn: objects)
                realmDB.add(blttObj, update: .modified)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func saveComingMovie(movies: [Movie]) {
        do {
            try realmDB.write{
                let objects = movies.map{ $0.toMovieObject() }
                realmDB.add(objects, update: .modified)
                let blttObj = BelongToTypeObject()
                blttObj.name = "Coming Soon"
                blttObj.movies.append(objectsIn: objects)
                realmDB.add(blttObj, update: .modified)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func getShowingMovies(completion: @escaping ([Movie]) -> Void) {
        let result = realmDB.object(ofType: BelongToTypeObject.self, forPrimaryKey: "Now Showing")
        completion(result?.movies.map{ $0.toMovie() } ?? [])
    }
    
    func getComingMovies(completion: @escaping ([Movie]) -> Void) {
        let result = realmDB.object(ofType: BelongToTypeObject.self, forPrimaryKey: "Coming Soon")
        completion(result?.movies.map{ $0.toMovie() } ?? [])
    }
    
    func saveMovieDetail(movie: Movie) {
        do {
            try realmDB.write{
                realmDB.add(movie.toMovieObject(), update: .modified)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func getMovieDetail(id: Int, completion: @escaping (Movie?) -> Void) {
        let result = realmDB.object(ofType: MovieObject.self, forPrimaryKey: id)
        completion(result?.toMovie())
    }
}
