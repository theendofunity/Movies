//
//  TopMoviesViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import Foundation

class TopMoviesViewModel: MoviesViewModelType {
    
    var movies: [Movie] = []
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType? {
        nil
    }
    
    func loadMovies() {
        
    }
}
