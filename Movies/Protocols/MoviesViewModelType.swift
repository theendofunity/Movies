//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

protocol MoviesViewModelType {
    var currentPage: Int { get set }
    var lastPage: Int { get set }

    var movies: [Movie] { get set }
    
    func numberOfItems() -> Int
    func cellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType?
    
    func loadMovies(completion: @escaping (() -> Void))
}
