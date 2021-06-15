//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

protocol MoviesViewModelType {
    func numberOfItems() -> Int
    
    func cellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType?
}
