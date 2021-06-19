//
//  MovieCellViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit
import RealmSwift

class MovieCellViewModel: MovieCellViewModelType {
    var movie: Movie
    
    var updateCompletion: (() -> Void)?
    var observer: NotificationToken?
    
    init(movie: Movie) {
        self.movie = movie
        observer = RealmManager.movies.observe { [weak self] changes in
            switch changes {
            case .update:
                movie.isFavorite = RealmManager.isMovieInDataBase(title: movie.title)
                self?.updateCompletion?()
            default:
                break
            }
        }
    }
    
    func isFavorite() -> Bool {
        return movie.isFavorite
    }
    
    func changeFavoriteState() {
        movie.isFavorite = !movie.isFavorite
        
        if movie.isFavorite {
            let dataBaseMovie = DataBaseMovie(title: movie.title, posterUrl: movie.posterUrl)
            RealmManager.saveFavoriteMovie(movie: dataBaseMovie)
        } else {
            RealmManager.removeMovieWithTitle(title: movie.title)
        }
    }
    
    func title() -> String? {
        return movie.title
    }
    
    func moviePosterUrl() -> String? {
        return "https://image.tmdb.org/t/p/w500/" + movie.posterUrl
    }
}
