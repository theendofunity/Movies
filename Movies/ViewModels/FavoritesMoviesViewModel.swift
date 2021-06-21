//
//  FavoritesMoviesViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 18.06.2021.
//

import Foundation
import RealmSwift

class FavoritesMoviesViewModel: Observable {
    var updateCompletion: (() -> Void)?
        
    init() {
        RealmManager.shared.addObserver(observer: self)
    }
    
    func numberOfItems() -> Int {
        return RealmManager.shared.movies?.count ?? 0
    }
    
    func cellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType? {
        guard let dataBaseMovie = RealmManager.shared.movies?[indexPath.item] else { return nil }
        let movie = Movie(with: dataBaseMovie)
        
        let cellModel = MovieCellViewModel(movie: movie)
        return cellModel
    }
    
    func deleteMovie() {
        
    }
}
