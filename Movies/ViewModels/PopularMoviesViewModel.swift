//
//  PopularMoviesViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import Foundation

class PopularMoviesViewModel: MoviesViewModelType {
    var currentPage: Int = 0
    var lastPage: Int = 1
    var movies: [Movie] = []
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType? {
        let cellModel = MovieCellViewModel(movie: movies[indexPath.item])
        return cellModel
    }
    
    func loadMovies(completion: @escaping (() -> Void)) {
        guard currentPage <= lastPage else {
            print("Last page")
            return
        }
        
        currentPage += 1

        let request = PopularRequest(page: currentPage)
        
        ApiService.shared.fetchData(from: request.url()) { [weak self] (result: Result<MoviesData, Error>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self?.lastPage = data.totalPages
                
                for newMovie in data.results {
                    guard let movie = Movie(with: newMovie) else { continue }
                    self?.movies.append(movie)
                }
                completion()
            }
        }
    }
}
