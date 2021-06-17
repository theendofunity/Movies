//
//  MovieCellViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

class MovieCellViewModel: MovieCellViewModelType {
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func title() -> String? {
        return movie.title
    }
    
    func moviePosterUrl() -> String? {
        return "https://image.tmdb.org/t/p/w500/" + movie.posterUrl
    }
}
