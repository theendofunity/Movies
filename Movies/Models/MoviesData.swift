//
//  MoviesData.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 16.06.2021.
//

import Foundation

struct MoviesData: Codable {
    let page: Int
    let results: [ResultData]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct ResultData: Codable {
    let title: String?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
    }
}
