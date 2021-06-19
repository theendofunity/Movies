//
//  FavoritesMoviesViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 18.06.2021.
//

import Foundation
import RealmSwift

class FavoritesMoviesViewModel {
//    var movies: Results<DataBaseMovie> = RealmManager.loadFavoriteMovies()
    var updateCompletion: (() -> Void)?
    var observer: NotificationToken?
        
    init() {
        observer = RealmManager.movies.observe { [weak self] changes in
            switch changes {
            case .initial:
                self?.updateCompletion?()
                break
            case .update:
                self?.updateCompletion?()
                break
            case .error:
                break
            }
        }
    }
    
    func numberOfItems() -> Int {
        return RealmManager.movies.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType? {
        let dataBaseMovie = RealmManager.movies[indexPath.item]
        let movie = Movie(with: dataBaseMovie)
        
        let cellModel = MovieCellViewModel(movie: movie)
        return cellModel
    }
    
    func deleteMovie() {
        
    }
}
