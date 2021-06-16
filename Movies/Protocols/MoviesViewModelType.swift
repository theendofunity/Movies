//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

protocol MoviesViewModelType {
    var movies: [Movie] { get set }
    
    func numberOfItems() -> Int
    func cellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType?
    
    func loadMovies()
}
