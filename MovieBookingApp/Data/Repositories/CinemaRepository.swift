//
//  CinemaRepository.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 08/05/2022.
//

import Foundation

protocol CinemaRepository {
    func saveCinemas(cinemas: [Cinema])
    func getCinemas(completion: @escaping ([Cinema]) -> Void)
    func getCinemaById(cinemaId: Int, completion: @escaping (Cinema?) -> Void)
}

class CinemaRepositoryImpl: BaseRepository, CinemaRepository {
    
    static let shared: CinemaRepository = CinemaRepositoryImpl()
    private override init() {
        super.init()
    }
    
    func saveCinemas(cinemas: [Cinema]) {
        do {
            try realmDB.write {
                realmDB.add(cinemas.map{ $0.toCinemaObject() }, update: .modified)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func getCinemas(completion: @escaping ([Cinema]) -> Void) {
        let objects = realmDB.objects(CinemaObject.self)
        completion(objects.map{ $0.toCinema() })
    }
    
    func getCinemaById(cinemaId: Int, completion: @escaping (Cinema?) -> Void) {
        let object = realmDB.object(ofType: CinemaObject.self, forPrimaryKey: cinemaId)
        completion(object?.toCinema())
    }
}
