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
    
    static let movies = loadFavoriteMovies()
    
    static func loadFavoriteMovies() -> Results<DataBaseMovie> {
        let movies = realm.objects(DataBaseMovie.self)
        return movies
    }
    
    static func isMovieInDataBase(title: String) -> Bool {
        return movies.contains { movie in
            return movie.title == title
        }
    }
    
    static func saveFavoriteMovie(movie: DataBaseMovie) {
        try? realm.write {
            realm.add(movie)
        }
    }
    
    static func removeFromFavorite(movie: DataBaseMovie?) {
        try? realm.write({
            guard let movie = movie else { return }
            realm.delete(movie)
        })
    }
    
    static func removeMovieWithTitle(title: String) {
        let movie = movies.first { movie in
            movie.title == title
        }
        removeFromFavorite(movie: movie)
//        realm.delete(movies.)
    }
    
    static func write(completion: () -> Void) {
        try? realm.write {
            completion()
        }
    }
}
