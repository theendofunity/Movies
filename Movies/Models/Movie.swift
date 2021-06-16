//
//  Movie.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 16.06.2021.
//

import UIKit

struct Movie {
    let title: String
    let posterUrl: String
    var poster: UIImage?
    
    init?(with data: ResultData) {
        if data.title.isEmpty || data.posterPath.isEmpty {
            return nil
        }
        
        title = data.title
        posterUrl = data.posterPath
    }
}
