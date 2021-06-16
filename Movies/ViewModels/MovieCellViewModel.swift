//
//  MovieCellViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

class MovieCellViewModel: MovieCellViewModelType {
    var title: String?
    var moviePosterUrl: String?
    var moviePoster: UIImage?

    init(movie: Movie) {
        self.title = movie.title
        self.moviePosterUrl = "https://image.tmdb.org/t/p/w500/" + movie.posterUrl
    }
}
