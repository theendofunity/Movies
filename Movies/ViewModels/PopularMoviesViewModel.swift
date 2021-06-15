//
//  PopularMoviesViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import Foundation

class PopularMoviesViewModel: MoviesViewModelType {
    func numberOfItems() -> Int {
        10
    }
    
    func cellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType? {
        nil
    }
    
    
}
