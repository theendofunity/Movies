//
//  RequestTypes.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 16.06.2021.
//

import Foundation

let baseUrl = "api.themoviedb.org"

enum RequestType {
    case none
    case popular
    case top
    case search
}

protocol Request {
    var path: String { get }
    var requestType: RequestType { get }
    func url() -> URL?
}

struct PopularRequest: Request {
    let requestType: RequestType = .popular
    
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
    let requestType: RequestType = .top

    let path = "/3/movie/top_rated"
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
    let requestType: RequestType = .search

    let path = "/3/search/movie"
    var query: String
    let page: Int

    func url() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseUrl
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        return urlComponents.url
    }
}
