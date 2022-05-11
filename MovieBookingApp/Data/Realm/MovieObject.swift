//
//  MovieObject.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 07/05/2022.
//

import Foundation
import RealmSwift

class MovieObject : Object {
    @Persisted(primaryKey: true)
    var id: Int
    @Persisted
    var originalTitle: String?
    @Persisted
    var releaseDate: String?
    @Persisted
    var genres: List<String>
    @Persisted
    var overview: String?
    @Persisted
    var rating: Double?
    @Persisted
    var runtime: Int?
    @Persisted
    var posterPath: String?
    @Persisted
    var casts: List<CastObject>
    @Persisted(originProperty: "movies")
    var belongToType: LinkingObjects<BelongToTypeObject>
}

extension MovieObject {
    func toMovie() -> Movie {
        return Movie(id: id, originalTitle: originalTitle, releaseDate: releaseDate, genres: genres.map{ $0 }, overview: overview, rating: rating, runtime: runtime, posterPath: posterPath, casts: casts.map{ $0.toCast() })
    }
}
