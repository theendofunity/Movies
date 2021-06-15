//
//  SearchViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 16.06.2021.
//

import Foundation

class SearchViewModel: SearchViewModelType {
    func cellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType? {
        nil
    }
    
    func numberOfRows() -> Int {
        5
    }
    
    func search(for title: String) {
        
    }
    
    
}
