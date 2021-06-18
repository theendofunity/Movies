//
//  FavoritesMoviesViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 18.06.2021.
//

import Foundation
import RealmSwift

class FavoritesMoviesViewModel {
    var movies: Results<Movie> = RealmManager.loadFavoriteMovies()
    var updateCompletion: (() -> Void)?
    var observer: NotificationToken?
        
    init() {
        observer = movies.observe { [weak self] changes in
            switch changes {
            case .initial:
                self?.updateCompletion?()
                print(self?.movies.count)
                break
            case .update:
                self?.updateCompletion?()
                print(self?.movies.count)
                break
            case .error:
                break
            }    }
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType? {
        let cellModel = MovieCellViewModel(movie: movies[indexPath.item])
        return cellModel
    }
    
    func deleteMovie() {
        
    }
}
