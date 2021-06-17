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
        
        self.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        setupLayout()
    }
    
    //    MARK:  - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
//    MARK: - UISetup
    
    private func setupLayout() {
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = searchController.searchBar
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
            viewModel.query = searchController.searchBar.text!
            
            viewModel.movies.removeAll()
            
            viewModel.loadMovies { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
