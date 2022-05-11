//
//  BelongToTypeObject.swift
//  MovieBookingApp
//
//  Created by Htet Aung Lin on 08/05/2022.
//
import Foundation
import RealmSwift

class BelongToTypeObject: Object {
    @Persisted(primaryKey: true)
    var name: String?
    @Persisted
    var movies: List<MovieObject>
}
