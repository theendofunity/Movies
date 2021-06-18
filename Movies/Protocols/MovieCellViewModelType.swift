//
//  MovieCellViewModelType.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

protocol MovieCellViewModelType {
    var movie: Movie { get set }
    
    func title() -> String?
    func moviePosterUrl() -> String?
    
    func isFavorite() -> Bool
    func changeFavoriteState()
    
}
