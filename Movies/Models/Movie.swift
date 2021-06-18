//
//  Movie.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 16.06.2021.
//

import UIKit
import RealmSwift

class Movie: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var posterUrl: String = ""
    @objc dynamic var isFavorite = false
    
    convenience init?(with data: ResultData) {
        guard let title = data.title,
              let posterUrl = data.posterPath
        else { return nil }
        
        if title.isEmpty || posterUrl.isEmpty {
            return nil
        }
        
        self.init()
        
        self.title = title
        self.posterUrl = posterUrl
    }
    
    convenience init(with dataBase: DataBaseMovie) {
        self.init()

        self.title = dataBase.title
        self.posterUrl = dataBase.posterUrl
        self.isFavorite = true
    }
}
