// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieResponse = try? newJSONDecoder().decode(MovieResponse.self, from: jsonData)

import Foundation

//let id: Int?
//let originalTitle, releaseDate: String?
//let genres: [String]?
//let posterPath: String?


// MARK: - Movie
struct Movie: Codable {
    let id: Int
    let originalTitle, releaseDate: String?
    let genres: [String]?
    let overview: String?
    let rating: Double?
    let runtime: Int?
    let posterPath: String?
    let casts: [Cast]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres, overview, rating, runtime
        case posterPath = "poster_path"
        case casts
    }
}

extension Movie {
    func toMovieObject() -> MovieObject {
        let movieObj = MovieObject()
        movieObj.id = id
        movieObj.originalTitle = originalTitle
        movieObj.releaseDate = releaseDate
        movieObj.genres.append(objectsIn: genres ?? [])
        movieObj.overview = overview
        movieObj.rating = rating
        movieObj.runtime = runtime
        movieObj.posterPath = posterPath
        movieObj.casts.append(objectsIn: casts?.map{ $0.toCastObject() } ?? [])
        return movieObj
    }
}


// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}

extension Cast {
    func toCastObject() -> CastObject {
        let castObj = CastObject()
        castObj.adult = adult
        castObj.gender = gender
        castObj.id = id
        castObj.knownForDepartment = knownForDepartment
        castObj.name = name
        castObj.originalName = originalName
        castObj.popularity = popularity
        castObj.profilePath = profilePath
        castObj.castID = castID
        castObj.character = character
        castObj.creditID = creditID
        castObj.order = order
        return castObj
    }
}
