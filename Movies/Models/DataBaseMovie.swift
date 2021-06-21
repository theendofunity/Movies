//
//  DataBaseMovie.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 18.06.2021.
//

import UIKit
import RealmSwift

class DataBaseMovie: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var posterUrl: String = ""

     convenience init(title: String, posterUrl: String) {
        self.init()
        self.title = title
        self.posterUrl = posterUrl
    }
}
