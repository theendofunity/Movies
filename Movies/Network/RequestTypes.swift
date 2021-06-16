//
//  RequestTypes.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 16.06.2021.
//

import Foundation

let baseUrl = "api.themoviedb.org/"
//https://api.themoviedb.org/3/trending/movie/day?api_key=cc701e53a063a1bb08fdd2512e584b0e
//https://api.themoviedb.org/3/movie/top_rated?api_key=cc701e53a063a1bb08fdd2512e584b0e&language=en-US&page=1
//https://api.themoviedb.org/3/movie/popular?api_key=cc701e53a063a1bb08fdd2512e584b0e&language=en-US&page=1
//https://api.themoviedb.org/3/search/movie?api_key=cc701e53a063a1bb08fdd2512e584b0e&language=en-US&query=REQUEST&page=1


protocol Request {
    var path: String { get }
    
    func url() -> URL?
}

struct PopularRequest: Request {
    let path = "/3/movie/popular"
    let page: Int
    
    func url() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseUrl
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        return urlComponents.url
    }
}

struct TopRequest: Request {
    let path = "3/movie/top_rated"
    let page: Int

    func url() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseUrl
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        return urlComponents.url
    }
}

struct SearchRequest: Request {
    let path = "/3/search/movie"
    var query: String
    
    func url() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseUrl
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "query", value: query)
        ]
        
        return urlComponents.url
    }
}
