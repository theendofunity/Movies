//
//  TopMoviesViewModel.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import Foundation

class MoviesViewModel: MoviesViewModelType {
//    MARK: - Properties
    
    var query: String? {
        didSet {
            self.currentPage = 0
        }
    }
    var requestType: RequestType
    
    var currentPage: Int = 0
    var lastPage: Int = 10
    var movies: [Movie] = []
    
//    MARK: - Initializers
    
    init(type: RequestType) {
        self.requestType = type
    }
    
//    MARK: - Cells params
    func isLastPage() -> Bool {
        return currentPage == lastPage
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> MovieCellViewModelType? {
        let cellModel = MovieCellViewModel(movie: movies[indexPath.item])
        return cellModel
    }
    
//    MARK: - Loading
    
    func loadMovies(completion: @escaping (() -> Void)) {
        if isLastPage() {
            print("Last page")
            completion()
            return
        }
        
        currentPage += 1

        guard let request = createRequest() else { return }
        
        ApiService.shared.fetchData(from: request.url()) { [weak self] (result: Result<MoviesData, Error>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                self?.lastPage = data.totalPages
                
                for newMovie in data.results {
                    guard let movie = Movie(with: newMovie) else { continue }
                    
                    DispatchQueue.main.async { //set favorite state
                        if RealmManager.isMovieInDataBase(title: movie.title) {
                            movie.isFavorite = true
                        }
                    }
                    
                    self?.movies.append(movie)
                }
                completion()
            }
        }
        print(lastPage)
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
