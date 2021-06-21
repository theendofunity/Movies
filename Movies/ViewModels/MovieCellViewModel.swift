//
//  MovieCellViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit
import RealmSwift

class MovieCellViewModel: MovieCellViewModelType, Observable {
    var movie: Movie
    
    var updateCompletion: (() -> Void)?
    var uiUpdateCompletion: (() -> Void)?
    
    init(movie: Movie) {
        self.movie = movie
        
        updateCompletion = { [weak self] in
            movie.isFavorite = RealmManager.shared.isMovieInDataBase(title: movie.title)
            self?.uiUpdateCompletion?()
        }
        
        RealmManager.shared.addObserver(observer: self)
    }
    
    func isFavorite() -> Bool {
        return movie.isFavorite
    }
    
    func changeFavoriteState() {
        movie.isFavorite = !movie.isFavorite
        
        if movie.isFavorite {
            let dataBaseMovie = DataBaseMovie(title: movie.title, posterUrl: movie.posterUrl)
            RealmManager.shared.saveFavoriteMovie(movie: dataBaseMovie)
        } else {
            RealmManager.shared.removeMovieWithTitle(title: movie.title)
        }
    }
    
    func title() -> String? {
        return movie.title
    }
    
    func moviePosterUrl() -> String? {
        return "https://image.tmdb.org/t/p/w500/" + movie.posterUrl
    }
}
