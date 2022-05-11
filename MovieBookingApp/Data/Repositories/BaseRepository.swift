//
//  BaseRepository.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 07/05/2022.
//

import Foundation
import RealmSwift

class BaseRepository: NSObject {
    let realmDB = try! Realm()
    
    override init() {
            super.init()
            debugPrint("Default Realm is at \(realmDB.configuration.fileURL?.absoluteString ?? "undefined")")
    }
}
