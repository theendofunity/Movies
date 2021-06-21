//
//  ApiService.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 16.06.2021.
//

import Foundation

enum Errors: Error {
    case incorrectUrl
    case emptyData
    case decodeError
}


class ApiService {
    static func fetchData<T>(from url: URL?, completion: @escaping ((Result<T, Error>) -> Void)) where T: Decodable {
        print(url)
        guard let url = url else {
            completion(.failure(Errors.incorrectUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(error!))
            }
            
            guard let data = data else {
                completion(.failure(Errors.emptyData))
                return
            }
            if let apiData = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(apiData))
            } else {
                completion(.failure(Errors.decodeError))
            }
            
        }
        
        task.resume()
    }
}
