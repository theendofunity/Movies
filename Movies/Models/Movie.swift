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
    var isFavorite = false
    
    init?(with data: ResultData) {
        guard let title = data.title,
              let posterUrl = data.posterPath
        else { return nil }
        
        if title.isEmpty || posterUrl.isEmpty {
            return nil
        }
        
        self.title = title
        self.posterUrl = posterUrl
    }
}
