//
//  TopMoviesViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import Foundation

class MoviesViewModel: MoviesViewModelType {
    var query: String? {
        didSet {
            self.currentPage = 1
        }
    }
    var requestType: RequestType
    
    var currentPage: Int = 1
    var lastPage: Int = 10
    var movies: [Movie] = []
    
    init(type: RequestType) {
        self.requestType = type
    }
    
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
        
        guard let request = createRequest() else { return }
        
        currentPage += 1
        
        ApiService.shared.fetchData(from: request.url()) { [weak self] (result: Result<MoviesData, Error>) in
            switch result {
            case .failure(let error):
                print(error)
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
    
    private func createRequest()  -> Request?{
        let request: Request
        
        switch requestType {
        case .popular:
            request = PopularRequest(page: currentPage)
        case .top:
            request = TopRequest(page: currentPage)
        case .search:
            guard let query = query else {
                return nil
            }
            request = SearchRequest(query: query, page: currentPage)
        case .none:
            return nil
        }
        return request
    }
}
