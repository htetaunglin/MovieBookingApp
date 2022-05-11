//
//  CastObject.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 07/05/2022.
//

import Foundation
import RealmSwift

class CastObject: Object {
    @Persisted
    var adult: Bool?
    @Persisted
    var gender: Int?
    @Persisted(primaryKey: true)
    var id: Int
    @Persisted
    var knownForDepartment: String?
    @Persisted
    var name: String?
    @Persisted
    var originalName: String?
    @Persisted
    var popularity: Double?
    @Persisted
    var profilePath: String?
    @Persisted
    var castID: Int?
    @Persisted
    var character: String?
    @Persisted
    var creditID: String?
    @Persisted
    var order: Int?
}

extension CastObject{
    func toCast() -> Cast {
        return Cast(adult: adult, gender: gender, id: id, knownForDepartment: knownForDepartment, name: name, originalName: originalName, popularity: popularity, profilePath: profilePath, castID: castID, character: character, creditID: creditID, order: order)
    }
}



