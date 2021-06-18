//
//  RealmManager.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 18.06.2021.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class RealmManager {
    static func loadFavoriteMovies() -> Results<Movie> {
        let movies = realm.objects(Movie.self)
        return movies
    }
    
    static func saveFavoriteMovie(movie: Movie) {
        try? realm.write {
            realm.add(movie)
        }
    }
    
    static func removeFromFavorite(movie: Movie) {
        try? realm.write({
            realm.delete(movie)
        })
    }
    
    static func write(completion: () -> Void) {
        try? realm.write {
            completion()
        }
    }
}
