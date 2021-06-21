//
//  RealmManager.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 18.06.2021.
//

import Foundation
import RealmSwift

class RealmManager {
    let realm = try? Realm()

    static let shared: RealmManager = RealmManager()

    var movies: Results<DataBaseMovie>?
    var token: NotificationToken?

    var observers = [Observable]()

    init() {
        self.movies = self.loadFavoriteMovies()

        token = movies?.observe { [weak self] changes in
               switch changes {
               case .update:
                   guard let self = self else { return }
                   for observer in self.observers {
                       observer.updateCompletion?()
                   }
               default:
                   break
               }
           }

    }

    func addObserver(observer: Observable) {
        observers.append(observer)
    }

    func loadFavoriteMovies() -> Results<DataBaseMovie>? {
        guard let realm = realm else { return nil }
        let movies = realm.objects(DataBaseMovie.self)
        return movies
    }

    func isMovieInDataBase(title: String) -> Bool {
        guard let movies = movies else { return false }

        return movies.contains { movie in
            return movie.title == title
        }
    }

    func saveFavoriteMovie(movie: DataBaseMovie) {
        guard let realm = realm else { return }

        try? realm.write {
            realm.add(movie)
        }
    }

    func removeFromFavorite(movie: DataBaseMovie?) {
        guard let realm = realm else { return }

        try? realm.write({
            guard let movie = movie else { return }
            realm.delete(movie)
        })
    }

    func removeMovieWithTitle(title: String) {
        let movie = movies?.first { movie in
            movie.title == title
        }
        if movie != nil {
            removeFromFavorite(movie: movie)
        }
    }

    func write(completion: () -> Void) {
        guard let realm = realm else { return }

        try? realm.write {
            completion()
        }
    }
}
