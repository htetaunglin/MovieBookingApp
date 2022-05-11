//
//  SnackRepository.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 08/05/2022.
//

import Foundation

protocol SnackRepository {
    func getSnacks(completion: @escaping ([Snack]) -> Void)
    func saveSnacks(snack: [Snack])
}

class SnackRepositoryImpl: BaseRepository, SnackRepository {
    static let shared: SnackRepository = SnackRepositoryImpl()
    private override init() {
        super.init()
    }
    
    func getSnacks(completion: @escaping ([Snack]) -> Void) {
        let objects = realmDB.objects(SnackObject.self)
        completion(objects.map{ $0.toSnack() })
    }
    
    func saveSnacks(snack: [Snack]) {
        do {
            try realmDB.write {
                realmDB.add(snack.map{ $0.toSnackObject() }, update: .modified)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
