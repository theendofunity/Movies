//
//  MovieCellViewModelType.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

protocol MovieCellViewModelType {
    var moviePoster: UIImage? { get set }
    var title: String? { get set }
    var moviePosterUrl: String? { get set }

}
