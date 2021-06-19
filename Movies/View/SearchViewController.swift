//
//  SearchViewController.swift
//  Movies
//
//  Created by Дмитрий Дудкин on 15.06.2021.
//

import UIKit

class SearchViewController: UITableViewController {
    
    //    MARK: - Properties
    let viewModel: MoviesViewModel
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return true }
        return text.isEmpty
    }
    var searchDelayTimer: Timer?
    
    //    MARK: - Initializers

    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter movies title"
        definesPresentationContext = true
        
        self.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        self.tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.identifier)
        
        setupLayout()
    }
    
    //    MARK:  - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfItems = viewModel.numberOfItems()
        if numberOfItems == 0 { //data did not loading now
            return numberOfItems
        }
        return viewModel.numberOfItems() + 1 // +1 -- loading cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == viewModel.numberOfItems() {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.identifier, for: indexPath) as? LoadingTableViewCell else { return UITableViewCell() }
            print("loading cell")
            cell.activityIndicator.startAnimating()
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfItems() {
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.loadMore()
            }
        }
    }
    
//    MARK: - UISetup
    
    private func setupLayout() {
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = searchController.searchBar
        tableView.allowsSelection = false
    }
    
    private func loadMore() {
        viewModel.loadMovies { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}


extension SearchViewController: UISearchResultsUpdating {
    //    MARK:  - Search result
    
    func updateSearchResults(for searchController: UISearchController) {
        searchDelayTimer?.invalidate()
        
        searchDelayTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(search), userInfo: nil, repeats: false)
    }
    
    @objc private func search() {
        if !searchBarIsEmpty {
            viewModel.query = searchController.searchBar.text
            
            viewModel.movies.removeAll()
            
            loadMore()
        }
    }
}
