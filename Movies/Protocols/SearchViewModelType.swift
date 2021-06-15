//
//  SearchViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 16.06.2021.
//

import Foundation

protocol SearchViewModelType {
    
    func cellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType?
    func numberOfRows() -> Int
    
    func search(for title: String)
}
